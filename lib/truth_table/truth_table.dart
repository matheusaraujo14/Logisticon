// ignore_for_file: constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latext/latext.dart';
import 'package:badges/badges.dart' as badges;

// Image.asset('assets/Diagramas/$syllogismType.png',"This is an explanation of the $syllogismType Syllogism")
void main() {
  // runApp(const ShowTruthTableDeductions());
  //runApp(const ShowTruthTablePremisesConclusions());
  const ShowTruthTableDeductions();
  // runApp(const ProviderScope(child: EditableTableState()));

  //mainTest();
  //runApp(const MaterialConditionalTable());
}

class MaterialConditionalTable extends StatelessWidget {
  const MaterialConditionalTable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 500,
            height: 300,
            //child: truthTable(1, '~A v ~(A -> A)'),
            child: truthTableFormulaList([
              'A -> B',
            ], [
              '~A v B'
            ], colorSquareList: [
              (const Color.fromARGB(255, 249, 220, 218), (0, 0, 1, 2)),
              (const Color.fromARGB(255, 205, 230, 250), (2, 1, 3, 2)),
              (Colors.lightGreen, (1, 3, 4, 4)),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget latexText(String value,
    {Key? key,
    double height = 30,
    Color color = Colors.transparent,
    double vertical = 3,
    double horizontal = 3,
    double fontSize = 16,
    bool noDollar = false}) {
  return IntrinsicWidth(
    child: Container(
      key: key,
      height: height,
      color: color,
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Center(
        child: LaTexT(
          breakDelimiter: '%',
          laTeXCode: Text(
            noDollar ? value : r'$' '$value' r'$',
            style: TextStyle(
              fontSize: fontSize,
              height: 1.0,
            ),
          ),
        ),
      ),
    ),
  );
}

void addSubformula(List<(String, bool)> subformulaEval, String formulaStr,
    bool value, List<List<String>> table) {
  subformulaEval.add((formulaStr, value));
  table.add([formulaStr, value.toString()]);
}

abstract class Formula {
  bool eval(Map<String, bool> valuation);

  /// evaluate the formula according to the valuation (model) 'valuation'.
  /// Add to the list subformulaEval the text and value of the subformulas.
  /// Return the value of the formula
  bool evalSub(Map<String, bool> valuation, List<(String, bool)> subformulaEval,
      Set<String> subformulaSet);

  String asStr(bool topMostFormula) {
    return toString();
  }
}

class Variable extends Formula {
  final String name;

  Variable({required this.name});
  @override
  bool eval(Map<String, bool> valuation) {
    return valuation[name]!;
  }

  @override
  bool evalSub(Map<String, bool> valuation, List<(String, bool)> subformulaEval,
      Set<String> subformulaSet) {
    final v = valuation[name]!;
    // subformulaEval.add((name, v));
    return v;
  }

  @override
  String toString() {
    return name;
  }
}

class NegFormula extends Formula {
  final Formula formula;

  NegFormula(this.formula);
  @override
  bool eval(Map<String, bool> valuation) {
    return !formula.eval(valuation);
  }

  @override
  bool evalSub(Map<String, bool> valuation, List<(String, bool)> subformulaEval,
      Set<String> subformulaSet) {
    var v = !formula.eval(valuation);
    formula.evalSub(valuation, subformulaEval, subformulaSet);
    var str = toString();
    if (!subformulaSet.contains(str)) {
      subformulaSet.add(str);
      subformulaEval.add((str, v));
    }
    return v;
  }

  @override
  String toString() {
    return '\\neg $formula';
  }
}

class OperatorFormula extends Formula {
  final Formula left;
  final Formula right;
  final TokenType op;

  OperatorFormula({required this.left, required this.right, required this.op});
  @override
  bool eval(Map<String, bool> valuation) {
    switch (op) {
      case TokenType.ImpliesOperator:
        return !left.eval(valuation) || right.eval(valuation);
      case TokenType.BiconditionalOperator:
        return left.eval(valuation) == right.eval(valuation);

      case TokenType.OrOperator:
        return left.eval(valuation) || right.eval(valuation);
      case TokenType.AndOperator:
        return left.eval(valuation) && right.eval(valuation);
      default:
        throw 'Unknown operator: ${op.name}';
    }
  }

  @override
  bool evalSub(Map<String, bool> valuation, List<(String, bool)> subformulaEval,
      Set<String> subformulaSet) {
    var value = eval(valuation);
    var str = toString();
    if (!subformulaSet.contains(str)) {
      left.evalSub(valuation, subformulaEval, subformulaSet);
      right.evalSub(valuation, subformulaEval, subformulaSet);
      subformulaSet.add(str);
      subformulaEval.add((str, value));
    }
    return value;
  }

  @override
  String toString() {
    return '($left ${op.name} $right)';
  }

  @override
  String asStr(bool topMostFormula) {
    if (topMostFormula) {
      return '$left ${op.name} $right';
    } else {
      return toString();
    }
  }
}

enum TokenType {
  Variable(''),
  NegOperator(r'\not'),
  AndOperator(r'\land'),
  OrOperator(r'\lor'),
  ImpliesOperator(r'\to'),
  BiconditionalOperator(r'\leftrightarrow'),
  LParen(r'('),
  RParen(r')'),
  EOF(r'EOF');

  const TokenType(this.name);
  final String name;
}

class Token {
  final TokenType type;
  final String value;

  Token({required this.type, this.value = ''});
}

String _formulaStr = '';
int pos = 0;
Token tk = Token(type: TokenType.EOF);

void nextToken() {
  while (pos < _formulaStr.length &&
      (_formulaStr[pos] == ' ' || _formulaStr[pos] == '\t')) {
    pos++;
  }
  if (pos >= _formulaStr.length) {
    tk = Token(type: TokenType.EOF);
    return;
  }
  final c = _formulaStr[pos];
  pos++;
  switch (c) {
    case '~':
      tk = Token(type: TokenType.NegOperator, value: '~');
      return;
    case '^':
    case '&':
      tk = Token(type: TokenType.AndOperator, value: '^');
      return;

    case 'v':
    case '|':
      tk = Token(type: TokenType.OrOperator, value: 'v');
      return;
    case '-':
      if (pos < _formulaStr.length && _formulaStr[pos] == '>') {
        pos++;
        tk = Token(type: TokenType.ImpliesOperator, value: '->');
      } else {
        throw 'Unexpected character after -';
      }
      return;
    case '<':
      if (pos < _formulaStr.length && _formulaStr[pos] == '-') {
        pos++;
        if (pos < _formulaStr.length && _formulaStr[pos] == '>') {
          pos++;
          tk = Token(type: TokenType.BiconditionalOperator, value: '<->');
        } else {
          throw 'Unexpected character after <-';
        }
      } else {
        throw 'Unexpected character after <';
      }
      return;
    case '(':
      tk = Token(type: TokenType.LParen, value: '(');
      return;
    case ')':
      tk = Token(type: TokenType.RParen, value: ')');
      return;
    default:
      if (c.length == 1 && c.toUpperCase() == c) {
        tk = Token(type: TokenType.Variable, value: c);
      } else {
        throw 'Unexpected character: $c';
      }
  }
}

Formula parseFormula(String formulaStr) {
  pos = 0;
  _formulaStr = formulaStr;
  nextToken();
  Formula form = Variable(name: 'A');

  form = formula();
  if (tk.type != TokenType.EOF) {
    throw 'Unexpected token: "$tk", pos = $pos in "$formulaStr"';
  }
  return form;
}

Formula basicFormula() {
  switch (tk.type) {
    case TokenType.Variable:
      final token = tk;
      nextToken();
      return Variable(name: token.value);
    case TokenType.NegOperator:
      nextToken();
      final form = basicFormula();
      return NegFormula(form);
    case TokenType.LParen:
      nextToken();
      final form = formula();
      if (tk.type != TokenType.RParen) {
        throw 'Expected RParen, found: ${tk.value}';
      }
      nextToken();
      return form;
    default:
      throw 'Unexpected token: ${tk.value}';
  }
}

Formula formula() {
  return biconditionalFormula();
}

Formula biconditionalFormula() {
  var form = impliesFormula();
  while (tk.type == TokenType.BiconditionalOperator) {
    final opToken = tk;
    nextToken();
    final right = impliesFormula();
    form = OperatorFormula(left: form, right: right, op: opToken.type);
  }
  return form;
}

Formula impliesFormula() {
  var form = orFormula();
  while (tk.type == TokenType.ImpliesOperator) {
    final opToken = tk;
    nextToken();
    final right = orFormula();
    form = OperatorFormula(left: form, right: right, op: opToken.type);
  }
  return form;
}

Formula orFormula() {
  var form = andFormula();
  while (tk.type == TokenType.OrOperator) {
    final opToken = tk;
    nextToken();
    final right = andFormula();
    form = OperatorFormula(left: form, right: right, op: opToken.type);
  }
  return form;
}

Formula andFormula() {
  var form = basicFormula();
  while (tk.type == TokenType.AndOperator) {
    final opToken = tk;
    nextToken();
    final right = basicFormula();
    form = OperatorFormula(left: form, right: right, op: opToken.type);
  }
  return form;
}

void mainTest() {
  var valuation = {'A': true, 'B': false};
  for (var formStr in [
    '~~(A -> B) v (~A -> ~~B)',
    '(~(A->B) <-> (~A->~~B)) ^ ~~A ^ ~(~((~B)))',
    '~A -> ~B',
    'A -> B',
    '~A v B',
    'A ^ ~~B',
    'A <-> B',
    '~A',
  ]) {
    var form = parseFormula(formStr);
    var subformulaEval = <(String, bool)>[];
    var subformulaSet = <String>{};
    form.evalSub(valuation, subformulaEval, subformulaSet);
    print('$formStr: $subformulaEval');
    print('\n');
  }
}

bool isSingleLetter(String str) {
  return RegExp(r'^[a-zA-Z]$').hasMatch(str);
}

/// return the list of single-letter variables in the formula formulaStr
/// ordered by alphabetical order
List<String> getVariableFromFormula(String formulaStr) {
  var variables = <String>{};
  for (var ch in formulaStr.split('')) {
    // test if c is a single letter
    if (isSingleLetter(ch) && ch.toUpperCase() == ch && ch.length == 1) {
      variables.add(ch);
    }
  }
  var list = variables.toList();
  list.sort();
  return list;
}

/// return a tuple composed of the list of all variables of the formula formulaStr
/// ordered alphabetically and  all of the variations of truth values for the variables in the formula
/// formulaStr. This last value is something like:
/// [{A: true, B: true}, {A: true, B: false}, {A: false, B: true}, {A: false, B: false}]

(List<String>, List<Map<String, bool>>) getVariablesAllTruthVariations(
    String formulaStr) {
  List<String> variables = getVariableFromFormula(formulaStr);
  int numVariables = variables.length;
  List<Map<String, bool>> combinations = [];
  // Helper function to generate combinations recursively
  void generateCombination(int index, Map<String, bool> currentMap) {
    if (index == numVariables) {
      combinations.add(Map.from(currentMap));
      return;
    }
    currentMap[variables[index]] = true;
    generateCombination(index + 1, currentMap);
    currentMap[variables[index]] = false;
    generateCombination(index + 1, currentMap);
  }

  // Start generating combinations with an empty map
  generateCombination(0, {});
  return (variables, combinations);
}

List<String> removeEmptySingleLetter(
    List<String> formulaStrList, Set<String> removedVariablesSet) {
  List<String> newFormulaStrList = [];

  for (var formStr in formulaStrList) {
    var s = formStr.trim();
    if (s.isEmpty) {
      continue;
    }
    if (isSingleLetter(s)) {
      removedVariablesSet.add(s);
    }
    newFormulaStrList.add(s);
  }
  return newFormulaStrList;
}

Widget truthTableFormulaList(
    List<String> premisesStrList, List<String> conclusionStrList,
    {List<String>? incorrectConclusionsStrList,
    double fontSize = 12,
    List<
            (
              Color,
              (
                int lineTopLeft,
                int columnTopLeft,
                int lineBottomRight,
                int columnBottomRight
              )
            )>
        colorSquareList = const [],
    Color conclusionColor = const Color.fromARGB(255, 238, 238, 238),

    /// color to be put in the cells of the truth table that are premises and
    /// all of the premises are true
    Color premiseValuesColor = const Color.fromARGB(255, 247, 255, 240),
    Color premisesColor = const Color.fromARGB(255, 254, 251, 211)}) {
  Set<String> removedVariablesPremises = {};
  Set<String> removedVariablesConclusions = {};
  Set<String> removedVariablesIncorrectConclusions = {};
  premisesStrList =
      removeEmptySingleLetter(premisesStrList, removedVariablesPremises);
  conclusionStrList =
      removeEmptySingleLetter(conclusionStrList, removedVariablesConclusions);
  if (incorrectConclusionsStrList != null) {
    incorrectConclusionsStrList = removeEmptySingleLetter(
        incorrectConclusionsStrList, removedVariablesIncorrectConclusions);
  }
  List<String> formulaStrList =
      premisesStrList + conclusionStrList + (incorrectConclusionsStrList ?? []);
  List<Widget> firstLine = [];
  List<TableRow> otherTableRows = [];
  Map<int, TableColumnWidth> columnWidths = {};

  var newFormulaStrList = <String>[];
  var superFormula = '';
  for (var formStr in formulaStrList) {
    var s = formStr.trim();
    if (s.isEmpty || isSingleLetter(s)) {
      continue;
    }
    if (superFormula.isNotEmpty) {
      superFormula += ' ^ ';
    }
    superFormula += '( $formStr )';
    newFormulaStrList.add(formStr);
  }
  // eliminate empty formulas and single letter formulas
  formulaStrList = newFormulaStrList;
  //var form = parseFormula(superFormula);
  var (variableList, truthValueMap) =
      getVariablesAllTruthVariations(superFormula);
  var allFormulaList = <String>[];
  allFormulaList.addAll(variableList);

  // firstLine = List<Widget>.generate(
  //     variableList.length,
  //     (index) => latexText(variableList[index],
  //         color: colorForCell(0, index, colorSquareList), fontSize: fontSize));

  int index = 0;
  for (var varStr in variableList) {
    if (removedVariablesPremises.contains(varStr)) {
      firstLine
          .add(latexText(varStr, color: premisesColor, fontSize: fontSize));
    } else if (removedVariablesConclusions.contains(varStr)) {
      firstLine
          .add(latexText(varStr, color: conclusionColor, fontSize: fontSize));
    } else {
      firstLine.add(latexText(varStr,
          color: colorForCell(0, index, colorSquareList), fontSize: fontSize));
    }
    ++index;
  }
  List<Formula> formulaList = [];
  int column = variableList.length;
  for (var formStr in formulaStrList) {
    var form = parseFormula(formStr);
    formulaList.add(form);
    var subformulaEval = <(String, bool)>[];
    var subformulaSet = <String>{};
    form.evalSub(truthValueMap[0], subformulaEval, subformulaSet);
    var latexFormStr = subformulaEval.last.$1;
    if (form is OperatorFormula) {
      // remove the first ( and last )
      latexFormStr = latexFormStr.substring(1, latexFormStr.length - 1);
    }
    if (column <
        variableList.length +
            premisesStrList.length -
            removedVariablesPremises.length) {
      firstLine.add(
          latexText(latexFormStr, color: premisesColor, fontSize: fontSize));
    } else if (column >= variableList.length + premisesStrList.length) {
      firstLine.add(
          latexText(latexFormStr, color: conclusionColor, fontSize: fontSize));
    } else {
      firstLine.add(latexText(latexFormStr,
          color: colorForCell(0, column, colorSquareList), fontSize: fontSize));
    }
    // firstLine.add(latexText(latexFormStr,
    //     color: colorForCell(0, column, colorSquareList)));
    ++column;
    //allFormulaList.add(latexFormStr);
    allFormulaList.add(formStr);
  }

  double totalWidth = 0.0;
  int i = 0;
  for (var elem in allFormulaList) {
    /// size 10.0 for each variable of the table
    final widthColumn = sizeFormula(elem);
    totalWidth += widthColumn;
    columnWidths[i] =
        FixedColumnWidth(widthColumn); // FixedColumnWidth(7.0 * elem.length);
    ++i;
  }

  int line = 1;
  for (var valuation in truthValueMap) {
    int column = variableList.length;
    List<bool> formTruthList = [];
    i = 0;
    bool allPremisesTrue = true;
    while (i < variableList.length) {
      if (removedVariablesPremises.contains(variableList[i])) {
        allPremisesTrue = allPremisesTrue && valuation[variableList[i]]!;
        ++i;
      }
      ++i;
    }
    i = 0;
    for (var form in formulaList) {
      var subformulaEval = <(String, bool)>[];
      var subformulaSet = <String>{};
      form.evalSub(valuation, subformulaEval, subformulaSet);
      formTruthList.add(subformulaEval.last.$2);
      if (i < premisesStrList.length - removedVariablesPremises.length) {
        allPremisesTrue = allPremisesTrue && subformulaEval.last.$2;
      }
      ++i;
    }
    // List<Widget> row = List<Widget>.generate(
    //     variableList.length,
    //     (index) => latexText(valuation[variableList[index]]! ? 'T' : 'F',
    //         color: allPremisesTrue
    //             ? (premisesColor ?? colorForCell(line, index, colorSquareList))
    //             : colorForCell(line, index, colorSquareList)));
    int index = 0;
    List<Widget> row = [];
    for (var varStr in variableList) {
      if (removedVariablesPremises.contains(varStr) && allPremisesTrue) {
        row.add(
          latexText(valuation[varStr]! ? 'T' : 'F',
              color: premiseValuesColor, fontSize: fontSize),
        );
      } else {
        row.add(latexText(valuation[varStr]! ? 'T' : 'F',
            color: colorForCell(line, index, colorSquareList),
            fontSize: fontSize));
      }
      ++index;
    }
    i = 0;
    for (var form in formulaList) {
      //var form = parseFormula(formStr);
      // var subformulaEval = <(String, bool)>[];
      // var subformulaSet = <String>{};
      // form.evalSub(valuation, subformulaEval, subformulaSet);
      if (allPremisesTrue &&
          i < premisesStrList.length - removedVariablesPremises.length) {
        row.add(latexText(formTruthList[i] ? 'T' : 'F',
            color: premiseValuesColor, fontSize: fontSize));
      } else {
        row.add(latexText(formTruthList[i] ? 'T' : 'F',
            color: colorForCell(line, column, colorSquareList),
            fontSize: fontSize));
      }
      ++i;
      ++column;
    }
    otherTableRows.add(TableRow(children: row));
    ++line;
    //print('row.length = ${row.length}');
  }
  final numVariables = variableList.length;

  /// calculate numVariables to the power of 2
  final numLines = 1 << numVariables;

  var row = SizedBox(
    height: 35 * numLines.toDouble(),
    width: 2 * totalWidth,
    child: Table(
      //defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: columnWidths,
      //border: TableBorder.all(),
      border: const TableBorder(
          verticalInside: BorderSide(width: 1, style: BorderStyle.solid),
          horizontalInside: BorderSide(width: 1, style: BorderStyle.solid)),
      children: [
        TableRow(
          children: firstLine,
        ),
        ...otherTableRows
      ],
    ),
  );
  return row;
}

double sizeFormula(String formulaStr) {
  int i = 0;
  double size = 0.0;
  double basicSize = 7.0;
  formulaStr = formulaStr
      .replaceAll(r'\neg', '~')
      .replaceAll(r'\land', '^')
      .replaceAll(r'\lor', 'v')
      .replaceAll(r'\to', '->')
      .replaceAll(r'\leftrightarrow', '<->')
      .replaceAll(r'&', '^')
      .replaceAll(r'|', 'v');

  for (var elem in formulaStr.split('')) {
    switch (elem) {
      case 'v':
        size += basicSize;
        ++i;
        break;
      case '^':
        size += basicSize;
        ++i;
        break;
      case '~':
        size += basicSize;
        ++i;
        break;
      case '->':
        size += 10.0;
        i += 2;
        break;
      default:

        /// single letter
        size += 10;
        break;
    }
  }
  return size;
}

// return the color of (line, column) considering the list of colored squares
Color colorForCell(
    int line,
    int column,
    List<
            (
              Color,
              (
                int lineTopLeft,
                int columnTopLeft,
                int lineBottomRight,
                int columnBottomRight
              )
            )>
        colorSquareList) {
  for (var elem in colorSquareList) {
    if (line >= elem.$2.$1 &&
        line <= elem.$2.$3 &&
        column >= elem.$2.$2 &&
        column <= elem.$2.$4) {
      return elem.$1;
    }
  }
  return Colors.transparent;
}

class InstanceDeductionConclusion {
  /// deduction name
  final String name;

  /// list of premises in the language of logic using
  /// operators ->, v, ^, ~, parentheses, and variables that are single
  /// upper-case letters
  final List<String> premises;

  /// conclusion in the language of logic
  final String conclusion;

  /// true if 'conclusion' is a correct conclusion from the premises
  final bool isCorrect;

  /// list of colors for the squares of the truth table
  List<
      (
        Color color,
        (
          int lineTopLeft,
          int columnTopLeft,
          int lineBottomRight,
          int columnBottomRight
        )
      )> colorSquareList = [];

  String explanation;

  InstanceDeductionConclusion(
      {required this.name,
      required this.premises,
      required this.conclusion,
      required this.isCorrect,
      this.colorSquareList = const [],
      this.explanation = ''});
}

class ShowTruthTableDeductions extends StatefulWidget {
  const ShowTruthTableDeductions({super.key});

  @override
  State<ShowTruthTableDeductions> createState() =>
      _ShowTruthTableDeductionsState();
}

class _ShowTruthTableDeductionsState extends State<ShowTruthTableDeductions> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Deductions truth tables')),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            width: 800,
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.black),
                  crossAxisMargin: 4,
                  trackVisibility: MaterialStateProperty.all(true),
                  trackColor: MaterialStateProperty.all(Colors.grey),
                  trackBorderColor: MaterialStateProperty.all(Colors.black38),
                ),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                controller: _controller,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    controller: _controller,
                    //itemCount: deducList.length,
                    itemCount: deducList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            deducList[index].name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          deductionFromPremises(deducList[index], 12),
                          const SizedBox(height: 10),
                          truthTableFormulaList(deducList[index].premises,
                              [deducList[index].conclusion],
                              colorSquareList: deducList[index].colorSquareList,
                              fontSize: 12,
                              premiseValuesColor:
                                  const Color.fromARGB(255, 246, 204, 140)),

                          /// vertical space of 10
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 600,
                            child: Text(
                              deducList[index].explanation,
                              overflow: TextOverflow.visible,
                              maxLines: 6,
                            ),
                          ),
                          const SizedBox(height: 10),
                          latexText(
                              deducList[index].isCorrect
                                  ? 'Correct'
                                  : 'Incorrect',
                              color: deducList[index].isCorrect
                                  ? Colors.green
                                  : Colors.red),

                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget deductionFromPremises(InstanceDeductionConclusion idc, double size) {
    var s = '\\{ \\:';
    for (var formStr in idc.premises) {
      var f = parseFormula(formStr);

      s += '${f.asStr(true)}, ';
    }
    s = s.substring(0, s.length - 2);
    var f = parseFormula(idc.conclusion);

    s += ' \\:\\} \\vdash ${f.asStr(true)}';
    return LaTexT(
      breakDelimiter: '%',
      laTeXCode: Text(
        r'$' '$s' r'$',
        style: TextStyle(
          fontSize: size,
          height: 1.0,
        ),
      ),
    );
  }
}

Widget deductionFromPremisesPublic(
    List<String> premises, String conclusion, double size) {
  var s = '\\{ \\:';
  for (var formStr in premises) {
    var f = parseFormula(formStr);

    s += '${f.asStr(true)}, ';
  }
  s = s.substring(0, s.length - 2);
  var f = parseFormula(conclusion);

  s += ' \\:\\} \\vdash ${f.asStr(true)}';
  return LaTexT(
    breakDelimiter: '%',
    laTeXCode: Text(
      r'$' '$s' r'$',
      style: TextStyle(
        fontSize: size,
        height: 1.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class ShowTruthTablePremisesConclusions extends StatefulWidget {
  const ShowTruthTablePremisesConclusions({super.key});

  @override
  State<ShowTruthTablePremisesConclusions> createState() =>
      _ShowTruthTablePremisesConclusionsState();
}

class _ShowTruthTablePremisesConclusionsState
    extends State<ShowTruthTablePremisesConclusions> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Deductions truth tables')),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            width: 1500,
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.black),
                  crossAxisMargin: 4,
                  trackVisibility: MaterialStateProperty.all(true),
                  trackColor: MaterialStateProperty.all(Colors.grey),
                  trackBorderColor: MaterialStateProperty.all(Colors.black38),
                ),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                controller: _controller,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    controller: _controller,
                    //itemCount: deducList.length,
                    itemCount: allDeductionList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            allDeductionList[index].name,
                            style: const TextStyle(fontSize: 12),
                          ),

                          const SizedBox(height: 15),
                          truthTableFormulaList(
                              allDeductionList[index].premiseList,
                              allDeductionList[index].conclusionList,
                              premiseValuesColor:
                                  const Color.fromARGB(255, 246, 204, 140)),

                          /// vertical space of 10
                          const SizedBox(height: 30),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<({String name, List<String> premiseList, List<String> conclusionList})>
    allDeductionList = [
  (
    name: 'Implication',
    premiseList: ['A -> B'],
    conclusionList: [
      '~B -> ~A',
      'A',
      '~A',
      'B',
      '~B',
      'B -> A',
      '~B -> A',
      '~A -> ~B'
    ]
  ),
  (
    name: 'Modus ponens',
    premiseList: ['A -> B', 'A'],
    conclusionList: ['B', '~B -> A', '~A -> ~B', '~B']
  ),
  (
    name: 'Modus tollens',
    premiseList: ['A -> B', '~B'],
    conclusionList: ['~A', 'A ^ B', '~A -> A ^ B']
  ),
  (
    name: 'Modus tollendo ponens',
    premiseList: ['(A v B) ^ ~(A ^ B)', '~A'],
    conclusionList: ['B', '~B -> A', 'B -> A']
  ),
  (
    name: 'Modus ponendo tollens',
    premiseList: ['(A v B) ^ ~(A ^ B)', 'A'],
    conclusionList: ['~B', '~A -> B', 'B -> ~A', 'A -> ~B', '~B -> ~A']
  ),
  (
    name: 'Constructive Dilemma',
    premiseList: ['A -> C', 'B -> C', 'A v B'],
    conclusionList: [
      'C',
      'A v B -> C',
      '~C -> ~A ^ ~B',
      'A ^ B -> C',
      'C -> A v B',
    ]
  ),
  (
    name: 'Constructive Dilemma',
    premiseList: ['A -> C', 'B -> C', 'A v B'],
    conclusionList: ['~A -> C', '~C -> A ^ B', 'C -> A ^ B', 'C v A -> B']
  ),
  (
    name: 'Destructive Dilemma',
    premiseList: ['A -> B', 'A -> C', '~B v ~C'],
    conclusionList: [
      '~A',
      '~(B ^ C)',
      'A -> B ^ C',
      '~A -> ~B v ~C',
    ]
  ),
  (
    name: 'Destructive Dilemma',
    premiseList: ['A -> B', 'A -> C', '~B v ~C'],
    conclusionList: [
      'B v C -> A',
      'B ^C -> A',
      'B -> A',
    ]
  ),
  (
    name: 'Destructive Dilemma',
    premiseList: ['A -> B', 'A -> C', '~B v ~C'],
    conclusionList: ['B v C', '(B v C) ^ ~(B ^ C)']
  ),
  (
    name: 'Double implication',
    premiseList: ['A -> B', 'B -> C'],
    conclusionList: [
      'A -> C',
      '~C -> ~A',
      'A v B -> C ^ (A -> C)',
    ],
  ),
  (
    name: 'Double implication',
    premiseList: ['A -> B', 'B -> C'],
    conclusionList: [
      'A -> C ^(A -> C)',
      '~A ^ B -> C ^(A -> C)',
      'A v B -> C',
      'A',
    ],
  ),
  (
    name: 'Double implication',
    premiseList: ['A -> B', 'B -> C'],
    conclusionList: [
      'C -> A',
      'C -> ~A',
      'C',
      '~C',
      '~C -> A',
      '~B -> C',
      'A v ~B -> C'
    ],
  ),
  (
    name: 'Deduction 1',
    premiseList: ['A -> B', 'A -> C'],
    conclusionList: [
      'A -> B ^ C',
      'A -> B v C',
      '~B -> ~A',
      '~C -> ~A',
    ],
  ),
  (
    name: 'Deduction 1',
    premiseList: ['A -> B', 'A -> C'],
    conclusionList: [
      '~B v ~C -> ~A',
      '~B -> ~C',
      '~C -> ~B',
      'B -> C',
    ],
  ),
  (
    name: 'Deduction 1',
    premiseList: ['A -> B', 'A -> C'],
    conclusionList: ['C -> B', 'B ^ C -> A', 'B v C -> A', '~B v ~A -> A'],
  ),
  (
    name: 'Deduction 2',
    premiseList: ['A -> ~B', 'A -> C'],
    conclusionList: [
      'A -> ~B ^ C',
      'A -> ~B v C',
      'B -> ~A',
      '~C -> ~A',
    ],
  ),
  (
    name: 'Deduction 2',
    premiseList: ['A -> ~B', 'A -> C'],
    conclusionList: [
      'B v ~C -> ~A',
      'B -> ~C',
      '~C -> B',
      '~B -> C',
    ],
  ),
  (
    name: 'Deduction 2',
    premiseList: ['A -> ~B', 'A -> C'],
    conclusionList: ['C -> ~B', '~B ^ C -> A', '~B v C -> A', 'B v ~A -> A'],
  ),
  (
    name: 'Deduction 3',
    premiseList: ['~A -> B', 'A -> C'],
    conclusionList: [
      '~B -> A',
      '~C -> ~A',
      '~C -> B',
    ],
  ),
  (
    name: 'Deduction 3',
    premiseList: ['~A -> B', 'A -> C'],
    conclusionList: [
      'B v C',
      'A ^ B -> C',
      'B -> A',
      'B -> ~A',
    ],
  ),
  (
    name: 'Deduction 3',
    premiseList: ['~A -> B', 'A -> C'],
    conclusionList: ['~B -> ~A', 'B ^ C', 'C -> A', 'B ^ C -> A'],
  ),
];
/*

		. B implies A
		. B implies not A
		. not B implies not A
		. B and C
		. If C is true, A is true
		. If B and C, then A is true
		



*/

const colorLinesAllPremisesTrueCorrect = Color.fromARGB(255, 227, 249, 232);
const colorLinesAllPremisesTrueIncorrect = Color.fromARGB(255, 255, 115, 105);

const explanationForCorrectDeduction =
    'In the first line of the truth table, the formulas in yellow are the premises of the deduction '
    'and the formula in light gray is the conclusion. '
    'All cells in which all the premises are true are marked in light orange (if any). '
    'In the line of each light orange cell, the conclusion is marked in green because '
    'it is also true. '
    'Therefore, the conclusion is correct  because whenever the premises are true (light orange), '
    'the conclusion is also true (green).';

const explanationForIncorrectDeduction =
    'In the first line of the truth table, the formulas in yellow are the premises of the deduction '
    'and the formula in light gray is the conclusion. '
    'All cells in which all the premises are true are marked in light orange (if any). '
    'There is at least a line in which all the premises are true (light orange cells) '
    'and the conclusion is false (red cells). '
    'Therefore, the conclusion is incorrect because in at least one line, the premises are true (light orange) '
    'but the conclusion is false (red).';

List<InstanceDeductionConclusion> deducList = [
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~B -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueCorrect, (3, 3, 4, 3))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 0, 1, 0)),
        (colorLinesAllPremisesTrueIncorrect, (3, 0, 4, 0))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 3, 4, 3)),
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 1, 1, 1)),
        (colorLinesAllPremisesTrueCorrect, (3, 1, 3, 1)),
        (colorLinesAllPremisesTrueIncorrect, (4, 1, 4, 1))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3)),
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3))
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueCorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueIncorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~A -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: 'B',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 1, 1, 1)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: 'B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~A -> ~B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~B', //indicadores da linha nao aparecem
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3)),
      ],
      explanation: explanationForCorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~A',
      isCorrect: true, //indicadores das linhas nao aparecem
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'B -> A', //indicadores das linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~A -> ~B', //indicadores das linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~B -> A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 0, 4, 0))],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'A ^ B', //indicadores das linhas nao aparecem
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 1, 3, 1))],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 4, 3, 4))],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'A -> B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: '~B',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~B',
      isCorrect: true, //linhas nao aparecem
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~A -> B', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: 'B -> ~A', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: 'A -> ~B', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~B -> ~A', //linhas nao aparecem
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 2, 1, 2)),
        (colorLinesAllPremisesTrueCorrect, (3, 2, 3, 2)),
        (colorLinesAllPremisesTrueCorrect, (5, 2, 5, 2))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(A v B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~C -> (~A ^ ~B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(A ^ B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C -> (A v B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'A -> (B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~A -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~C -> (A ^ B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C -> (A ^ B)',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueIncorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueIncorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(C v A) -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueIncorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~(B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'A -> (B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),

  // . not A implies not B or not C
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~A -> (~B v ~C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),
  // B and C implies A
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'B ^ C -> A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),

  // . B or C implies A
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '(B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (6, 6, 7, 6)),
        (colorLinesAllPremisesTrueCorrect, (8, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (6, 6, 6, 6)),
        (colorLinesAllPremisesTrueCorrect, (7, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '(B ^ ~C) v (~B ^ C)',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 7, 6)),
        (colorLinesAllPremisesTrueIncorrect, (8, 6, 8, 6)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v B) -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(~A ^ B) -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 0, 1, 0)),
        (colorLinesAllPremisesTrueIncorrect, (5, 0, 5, 0)),
        (colorLinesAllPremisesTrueIncorrect, (7, 0, 8, 0)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 2, 1, 2)),
        (colorLinesAllPremisesTrueCorrect, (5, 2, 5, 2)),
        (colorLinesAllPremisesTrueCorrect, (7, 2, 7, 2)),
        (colorLinesAllPremisesTrueIncorrect, (8, 2, 8, 2)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v ~B) -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'A -> (B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'A -> (B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~B -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(~B v ~C) -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~B -> ~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~C -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'C -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(~B v ~A) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'A -> (~B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'A -> (~B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'B -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(B v ~C) -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'B -> ~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~C -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'C -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(~B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(~B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(B v ~A) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~C -> B',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B v C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '(A ^ B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction),

  // not B implies not A
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~B -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction),

  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B ^ C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '(B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeduction)
];
