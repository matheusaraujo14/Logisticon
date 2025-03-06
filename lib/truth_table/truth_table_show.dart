import 'package:new_test/truth_table/ast.dart';
import 'package:new_test/truth_table/compiler_prop_calculus.dart';
import 'package:new_test/truth_table/edit_table.dart';
import 'package:new_test/truth_table/generate_using_chatgpt.dart';
import 'package:new_test/truth_table/instance_deduction.dart';
import 'package:new_test/truth_table/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latext/latext.dart';
import 'package:new_test/truth_table/font_size.dart';
import 'package:provider/provider.dart';
import 'transtlate_tables.dart';
import 'package:new_test/global_language.dart';

const double _fontSizeExplanation = 16;

/// Show the truth table of a single deduction
class ShowDeductionTruthTable extends StatefulWidget {
  const ShowDeductionTruthTable({super.key, required this.deductionName});
  final String deductionName;

  @override
  State<ShowDeductionTruthTable> createState() =>
      _ShowDeductionTruthTableState();
}

class _ShowDeductionTruthTableState extends State<ShowDeductionTruthTable> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var subDeducList = deductionList
        .where((element) => element.name == widget.deductionName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Truth tables for ${widget.deductionName}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: 600,
          child: Theme(
            data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: WidgetStateProperty.all(Colors.black),
                crossAxisMargin: 4,
                trackVisibility: WidgetStateProperty.all(true),
                trackColor: WidgetStateProperty.all(Colors.grey),
                trackBorderColor: WidgetStateProperty.all(Colors.black38),
              ),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 10,
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 20, 0),
                child: ListView.builder(
                  controller: _controller,
                  itemCount: subDeducList.length,
                  itemBuilder: (context, index) {
                    return Consumer<LanguageProvider>(
                      builder: (context, languageProvider, child) {
                        int languageIndex =
                            languageProvider.currentLanguageIndex;

                        // Seleciona a explicação com base no idioma
                        String explanationToShow =
                            subDeducList[index].explanation[languageIndex];

                        return Column(
                          children: [
                            Text(
                              subDeducList[index].name,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            deductionFromPremises(subDeducList[index]),
                            const SizedBox(height: 10),
                            truthTableFormulaList(
                              subDeducList[index].premises,
                              [subDeducList[index].conclusion],
                              colorSquareList:
                                  subDeducList[index].colorSquareList,
                              fontSize: 12,
                              premiseValuesColor: const Color.fromARGB(
                                255,
                                246,
                                204,
                                140,
                              ),
                              conclusionColor: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 30),
                            // Exibe o texto com a explicação selecionada
                            SizedBox(
                              width: 600,
                              child: SelectableText(
                                explanationToShow,
                                style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                ),
                                maxLines: 6,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Caixa com a cor indicando se está correto ou incorreto
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: subDeducList[index].isCorrect
                                        ? Colors.green.withOpacity(0.5)
                                        : Colors.red.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: subDeducList[index].isCorrect
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Text(
                                subDeducList[index].isCorrect
                                    ? 'Correct'
                                    : 'Incorrect',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// stateful widget named ShowMenuDeductions with a MaterialApp and a Scaffold
/// that shows the deductions of list deductionNames, each one as a button.
/// When a button is pressed, the deduction is shown in a new page using
/// the widget ShowDeductionTruthTable.
///

class ShowMenuDeductions extends StatefulWidget {
  const ShowMenuDeductions({super.key});

  @override
  ShowMenuDeductionsState createState() => ShowMenuDeductionsState();
}

class ShowMenuDeductionsState extends State<ShowMenuDeductions> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Deductions')),
            body: ListView.builder(
              itemCount: deductionNameList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(deductionNameList[index]),
                        () {
                          var subDeductionList = deductionListByName(
                            deductionNameList[index],
                          );
                          if (subDeductionList.isEmpty) {
                            return const Text('No deductions');
                          }
                          return Row(
                            children:

                                ///
                                /// use latexText for the premises
                                List.generate(
                                    subDeductionList[0].premises.length, (
                              int i,
                            ) {
                              return Row(
                                children: [
                                  latexText(
                                    fontSize: 12,
                                    height: 16,
                                    addSpacesAfter: true,
                                    parseFormula(
                                      subDeductionList[0].premises[i],
                                    ).toString(),
                                  ),
                                ],
                              );
                            }),
                          );
                        }(),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowDeductionTruthTable(
                            deductionName: deductionNameList[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(
                    /// use icon for generating file
                    Icons.file_copy,
                  ),
                  label: 'Generate function for chatGPT',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    /// use icon for generating file
                    Icons.file_download_sharp,
                  ),
                  label: 'Generate description of description',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    /// use icon for generating file
                    Icons.single_bed_rounded,
                  ),
                  label: 'Show single deduction',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const GenerateFunctionForChatGPT(),
                      ),
                    );
                    _selectedIndex = 0;
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GenerateTextForDeductions(),
                      ),
                    );
                    _selectedIndex = 0;
                  } else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowSingleDeduction(),
                      ),
                    );
                    _selectedIndex = 0;
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}

Widget truthTableFormulaList(
  List<String> premisesStrList,
  List<String> conclusionStrList, {
  List<String>? incorrectConclusionsStrList,
  double fontSize = 12,
  List<
          (
            Color,
            (
              int lineTopLeft,
              int columnTopLeft,
              int lineBottomRight,
              int columnBottomRight,
            ),
          )>
      colorSquareList = const [],
  Color conclusionColor = const Color.fromARGB(255, 224, 224, 224),

  /// color to be put in the cells of the truth table that are premises and
  /// all of the premises are true
  Color premiseValuesColor = const Color.fromARGB(255, 247, 255, 240),
  Color premisesColor = const Color.fromARGB(255, 254, 251, 211),
  Color? backgroundTableColor,
  double extraHeight = 0.0,
}) {
  Set<String> removedVariablesPremises = {};
  Set<String> removedVariablesConclusions = {};
  Set<String> removedVariablesIncorrectConclusions = {};
  premisesStrList = removeEmptySingleLetter(
    premisesStrList,
    removedVariablesPremises,
  );
  conclusionStrList = removeEmptySingleLetter(
    conclusionStrList,
    removedVariablesConclusions,
  );
  if (incorrectConclusionsStrList != null) {
    incorrectConclusionsStrList = removeEmptySingleLetter(
      incorrectConclusionsStrList,
      removedVariablesIncorrectConclusions,
    );
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
  var (variableList, truthValueMap) = getVariablesAllTruthVariations(
    superFormula,
  );
  var allFormulaList = <String>[];
  allFormulaList.addAll(variableList);

  // firstLine = List<Widget>.generate(
  //     variableList.length,
  //     (index) => latexText(variableList[index],
  //         color: colorForCell(0, index, colorSquareList), fontSize: fontSize));

  int index = 0;
  for (var varStr in variableList) {
    if (removedVariablesPremises.contains(varStr)) {
      firstLine.add(
        latexText(varStr, color: premisesColor, fontSize: fontSize),
      );
    } else if (removedVariablesConclusions.contains(varStr)) {
      firstLine.add(
        latexText(varStr, color: conclusionColor, fontSize: fontSize),
      );
    } else {
      firstLine.add(
        latexText(
          varStr,
          color: colorForCell(0, index, colorSquareList),
          fontSize: fontSize,
        ),
      );
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
        latexText(latexFormStr, color: premisesColor, fontSize: fontSize),
      );
    } else if (column >= variableList.length + premisesStrList.length) {
      firstLine.add(
        latexText(latexFormStr, color: conclusionColor, fontSize: fontSize),
      );
    } else {
      firstLine.add(
        latexText(
          latexFormStr,
          color: colorForCell(0, column, colorSquareList),
          fontSize: fontSize,
        ),
      );
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
    columnWidths[i] = FixedColumnWidth(
      widthColumn,
    ); // FixedColumnWidth(7.0 * elem.length);
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
          latexText(
            valuation[varStr]! ? 'T' : 'F',
            color: premiseValuesColor,
            fontSize: fontSize,
          ),
        );
      } else {
        row.add(
          latexText(
            valuation[varStr]! ? 'T' : 'F',
            color: colorForCell(line, index, colorSquareList),
            fontSize: fontSize,
          ),
        );
      }
      ++index;
    }
    i = 0;
    for (var _ in formulaList) {
      //var form = parseFormula(formStr);
      // var subformulaEval = <(String, bool)>[];
      // var subformulaSet = <String>{};
      // form.evalSub(valuation, subformulaEval, subformulaSet);
      if (allPremisesTrue &&
          i < premisesStrList.length - removedVariablesPremises.length) {
        row.add(
          latexText(
            formTruthList[i] ? 'T' : 'F',
            color: premiseValuesColor,
            fontSize: fontSize,
          ),
        );
      } else {
        row.add(
          latexText(
            formTruthList[i] ? 'T' : 'F',
            color: colorForCell(line, column, colorSquareList),
            fontSize: fontSize,
          ),
        );
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
    height: 35 * numLines.toDouble() + extraHeight,
    width: 2 * totalWidth,
    child: LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: backgroundTableColor,
        child: Table(
          //defaultColumnWidth: const IntrinsicColumnWidth(),
          columnWidths: columnWidths,
          //border: TableBorder.all(),
          border: const TableBorder(
            verticalInside: BorderSide(width: 1, style: BorderStyle.solid),
            horizontalInside: BorderSide(
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          children: [TableRow(children: firstLine), ...otherTableRows],
        ),
      ),
    ),
  );
  return FittedBox(child: row);
}

Widget latexText(
  String value, {
  Key? key,
  double height = 30,
  double textStyleHeight = 1.0,
  Color color = Colors.transparent,
  double vertical = 3,
  double horizontal = 3,
  double fontSize = 16,
  bool addSpacesAfter = false,
  bool noDollar = false,
}) {
  var s = '';
  if (addSpacesAfter) {
    /// add to s as many '\\:' as the number of characters in value/3
    for (var i = 0; i < value.length ~/ 3; ++i) {
      s += '\\:';
    }
  }
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
            noDollar
                ? value
                : r'$'
                    '$value'
                    '$s'
                    r'$',
            style: TextStyle(fontSize: fontSize, height: textStyleHeight),
          ),
        ),
      ),
    ),
  );
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
              int columnBottomRight,
            ),
          )>
      colorSquareList,
) {
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

Widget deductionFromPremises(
  InstanceDeductionConclusion idc, {
  double fontSize = 12,
}) {
  var s = '\\{ \\:';
  for (var formStr in idc.premises) {
    var f = parseFormula(formStr);

    s += '${f.asStr(true)}, ';
  }
  s = s.substring(0, s.length - 2);
  var f = parseFormula(idc.conclusion);

  s += ' \\:\\} \\vDash ${f.asStr(true)}';
  return LaTexT(
    breakDelimiter: '%',
    laTeXCode: Text(
      r'$'
      '$s'
      r'$',
      style: TextStyle(fontSize: fontSize, height: 1.0),
    ),
  );
}

class ShowSingleDeduction extends StatefulWidget {
  const ShowSingleDeduction({super.key});

  @override
  State<ShowSingleDeduction> createState() => _ShowSingleDeductionState();
}

class _ShowSingleDeductionState extends State<ShowSingleDeduction> {
  String selectedDeductionName = 'Modus Ponens';

  Color iconColor = Colors.blue;
  List<InstanceDeductionConclusion> localSubDeductionList = [];
  int indexLocalSubDeductionList = 0;
  @override
  Widget build(BuildContext context) {
    /// Read the name of a deduction from the keyboard and a number (the deduction number
    /// in the subdeduction list of the deduction with the name entered)
    /// Then, show that specific deduction.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show single deduction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// a dropdown menu with all deduction names
            DropdownButton<String>(
              value: selectedDeductionName,
              hint: const Text('Select deduction name'),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(height: 2, color: Colors.deepPurpleAccent),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDeductionName = newValue!;
                });
              },
              items: deductionNameList.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            DropdownButton<int>(
              value: indexLocalSubDeductionList,
              hint: const Text('Select deduction number'),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.amber),
              underline: Container(height: 2, color: Colors.deepPurpleAccent),
              onChanged: (int? newValue) {
                setState(() {
                  indexLocalSubDeductionList = newValue!;
                });
              },
              items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map<DropdownMenuItem<int>>((
                int value,
              ) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            const Divider(),

            ElevatedButton(
              onPressed: () {
                localSubDeductionList = deductionListByName(
                  selectedDeductionName,
                );
                if (localSubDeductionList.isEmpty ||
                    indexLocalSubDeductionList >=
                        localSubDeductionList.length ||
                    indexLocalSubDeductionList < 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Invalid deduction number'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize:
                                    FontSizes(context).extraExtraExtraSmall,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Truth table for ${localSubDeductionList[indexLocalSubDeductionList].name} number $indexLocalSubDeductionList',
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      body: ShowSingleDeductionTruthTable(
                        deductionName:
                            localSubDeductionList[indexLocalSubDeductionList]
                                .name,
                        deductionNumber: indexLocalSubDeductionList,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Show deduction'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Show the truth table of a single deduction
class ShowSingleDeductionTruthTable extends StatefulWidget {
  const ShowSingleDeductionTruthTable({
    super.key,
    required this.deductionName,
    required this.deductionNumber,
    this.fontSizeExplanation = _fontSizeExplanation,
  });
  final String deductionName;
  final int deductionNumber;
  final double fontSizeExplanation;

  @override
  State<ShowSingleDeductionTruthTable> createState() =>
      _ShowSingleDeductionTruthTableState();
}

class _ShowSingleDeductionTruthTableState
    extends State<ShowSingleDeductionTruthTable> {
  final ScrollController _controller = ScrollController();
  Widget _introductionWidget() {
    /// if the deduction name has the patter 'deduction number' then return
    /// 'This deduction does not have a consolidated name. Let us call it \'deduction number\''.
    /// Otherwise, return 'The name of this deduction is deduction name'.

    final List<String> nodeductionnametranslations = [
      // Árabe
      "لا يوجد لهذا الاستنتاج اسم موحد. دعونا نطلق عليه \'${widget.deductionName}\'.",
      // Mandarim
      "这个推理没有统一的名称。我们称之为\'${widget.deductionName}\'.",
      // Alemão
      "Dieser Schluss hat keinen konsolidierten Namen. Lassen Sie uns ihn \'${widget.deductionName}\' nennen.",
      // Inglês
      "This deduction does not have a consolidated name. Let us call it \'${widget.deductionName}\'.",
      // Francês
      "Cette déduction n'a pas de nom consolidé. Appelons-la \'${widget.deductionName}\'.",
      // Hindi
      "इस निष्कर्ष का कोई एकीकृत नाम नहीं है। आइए इसे \'${widget.deductionName}\' कहें।",
      // Japonês
      "この推論には統合された名前がありません。\'${widget.deductionName}\' と呼びましょう。",
      // Português
      "Esta dedução não possui um nome consolidado. Vamos chamá-la de \'${widget.deductionName}\'.",
      // Espanhol
      "Esta deducción no tiene un nombre consolidado. Llamémosla \'${widget.deductionName}\'.",
    ];

    final List<String> deductionNameTranslations = [
      // Árabe
      "اسم هذا الاستنتاج هو ${widget.deductionName}.",
      // Mandarim
      "这个推理的名称是 ${widget.deductionName}。",
      // Alemão
      "Der Name dieser Deduktion ist ${widget.deductionName}.",
      // Inglês
      "The name of this deduction is ${widget.deductionName}.",
      // Francês
      "Le nom de cette déduction est ${widget.deductionName}.",
      // Hindi
      "इस निष्कर्ष का नाम ${widget.deductionName} है।",
      // Japonês
      "この推論の名前は ${widget.deductionName} です。",
      // Português
      "O nome desta dedução é ${widget.deductionName}.",
      // Espanhol
      "El nombre de esta deducción es ${widget.deductionName}.",
    ];

    var dn = widget.deductionName.toLowerCase().trim();
    var r = '';

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Se o nome da dedução tiver o padrão 'deduction number'
        if (RegExp(r'deduction \s*[0-9]').hasMatch(dn)) {
          r = nodeductionnametranslations[
              languageProvider.currentLanguageIndex];
        } else {
          r = deductionNameTranslations[languageProvider.currentLanguageIndex];
        }
        final List<String> textdeductionExplanationTranslations = [
          // Árabe
          " ما يتبع هو كيف يتم تمثيل هذا الاستنتاج ",
          // Mandarim
          " 接下来的是如何表示这个推理 ",
          // Alemão
          " Was als Nächstes folgt, ist, wie diese Deduktion dargestellt wird ",
          // Inglês
          " What follows next is how this deduction is ",
          // Francês
          " Ce qui suit est comment cette déduction est ",
          // Hindi
          " जो अगला आता है वह यह है कि यह निष्कर्ष कैसे प्रदर्शित होता है ",
          // Japonês
          " 次に続くのは、この推論がどのように表現されるかです ",
          // Português
          " O que se segue é como esta dedução é ",
          // Espanhol
          " Lo que sigue es cómo se representa esta deducción ",
        ];
        // Retorna o RichText com a tradução correta
        return RichText(
          overflow: TextOverflow.visible,
          softWrap: true,
          maxLines: null,
          text: TextSpan(
            text:
                '$r ${textdeductionExplanationTranslations[languageProvider.currentLanguageIndex]}',
            style: DefaultTextStyle.of(
              context,
            ).style.copyWith(fontSize: widget.fontSizeExplanation),
            children: <TextSpan>[
              TextSpan(
                text: formallyRepresentedTranslations[
                    languageProvider.currentLanguageIndex],
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: widget.fontSizeExplanation,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _showFormalTermsDialog(context);
                  },
              ),
              TextSpan(
                text: followedByATranslations[
                    languageProvider.currentLanguageIndex],
                style: DefaultTextStyle.of(
                  context,
                ).style.copyWith(fontSize: widget.fontSizeExplanation),
              ),
              TextSpan(
                text: truthTableTranslations[
                    languageProvider.currentLanguageIndex],
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: widget.fontSizeExplanation,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _showTruthTableDialog(context);
                  },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFormalTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              // Obtém o índice do idioma
              int index = languageProvider.currentLanguageIndex;

              return Text(
                formalTermsTranslations[index],
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: FontSizes(context).extraExtraSmall,
                ),
              );
            },
          ),
          content: FormalDeduction(
            fontSizeExplanation: widget.fontSizeExplanation,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: FontSizes(context).extraExtraExtraSmall,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTruthTableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return AlertDialog(
              title: Text(
                truthTableTranslations[languageProvider.currentLanguageIndex],
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: FontSizes(context).extraExtraSmall,
                ),
              ),
              content: TruthTableShowExplanation(
                fontSizeExplanation: FontSizes(context).extraExtraSmall,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: FontSizes(context).extraExtraExtraSmall,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String toTitleCase(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text.split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    /// variable subDeducList is a sublist of deducList in which  the name
    /// is 'Modus Ponendo Tollens'
    var subDeducList = deductionList
        .where(
          (element) =>
              toTitleCase(element.name).trim() ==
              toTitleCase(widget.deductionName).trim(),
        )
        .toList();

    if (subDeducList.isEmpty ||
        widget.deductionNumber >= subDeducList.length ||
        widget.deductionNumber < 0) {
      return const Scaffold(body: Center(child: Text('No deduction found')));
    }
    var theDeduction = subDeducList[widget.deductionNumber];

    /// push a new route to the navigator stack with a button to return to
    /// the previous screen

    /// add a back button, action Navigator.pop(context) with a text 'Back'
    /// to the previous screen

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Obtém o índice do idioma
        int index = languageProvider.currentLanguageIndex;

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            width: 600,
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: theDeduction.isCorrect
                      ? WidgetStateProperty.all(Colors.green)
                      : WidgetStateProperty.all(Colors.red),
                  crossAxisMargin: 4,
                  trackVisibility: WidgetStateProperty.all(false),
                ),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 8,
                controller: _controller,
                child: ListView(
                  controller: _controller,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: FontSizes(context).small),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _introductionWidget(),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              _showFormalTermsDialog(context);
                            },
                            onDoubleTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      formalTermsTranslations[index],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize:
                                            FontSizes(context).extraExtraSmall,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    content: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth:
                                            theDeduction.premises.length * 200,
                                      ),
                                      child: SingleChildScrollView(
                                        child: deductionFromPremises(
                                          theDeduction,
                                          fontSize: FontSizes(
                                            context,
                                          ).extraExtraSmall,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                            fontSize: FontSizes(
                                              context,
                                            ).extraExtraExtraSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: deductionFromPremises(
                              theDeduction,
                              fontSize: FontSizes(context).extraExtraExtraSmall,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              _showTruthTableDialog(context);
                            },
                            hoverColor: Colors.white,
                            onDoubleTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      truthTableTranslations[index],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize:
                                            FontSizes(context).extraExtraSmall,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    content: InteractiveViewer(
                                      child: truthTableFormulaList(
                                        extraHeight: 3,
                                        theDeduction.premises,
                                        [theDeduction.conclusion],
                                        colorSquareList:
                                            theDeduction.colorSquareList,
                                        fontSize:
                                            FontSizes(context).extraExtraSmall,
                                        conclusionColor: Colors.grey.shade300,
                                        premiseValuesColor:
                                            const Color.fromARGB(
                                          255,
                                          246,
                                          204,
                                          140,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                            fontSize: FontSizes(
                                              context,
                                            ).extraExtraExtraSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: truthTableFormulaList(
                              theDeduction.premises,
                              [theDeduction.conclusion],
                              colorSquareList: theDeduction.colorSquareList,
                              fontSize: FontSizes(context).extraExtraExtraSmall,
                              premiseValuesColor: const Color.fromARGB(
                                255,
                                246,
                                204,
                                140,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Exibição da explicação com o idioma correto
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectableText(
                              theDeduction.explanation[index],
                              maxLines: null,
                              style: TextStyle(
                                fontSize: widget.fontSizeExplanation,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Container com o texto "Correct Answer" ou "Incorrect"
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: theDeduction.isCorrect
                                      ? const Color.fromARGB(
                                          255,
                                          13,
                                          119,
                                          17,
                                        )
                                      : const Color.fromARGB(
                                          255,
                                          131,
                                          18,
                                          18,
                                        ),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: theDeduction.isCorrect
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              theDeduction.isCorrect
                                  ? main_correctAnswerTranslations[index]
                                  : incorrectTranslations[index],
                              style: TextStyle(
                                fontSize: FontSizes(context).extraSmall,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TruthTableShowExplanation extends StatefulWidget {
  const TruthTableShowExplanation({
    super.key,
    required this.fontSizeExplanation,
  });

  final double fontSizeExplanation;
  @override
  State<TruthTableShowExplanation> createState() =>
      _TruthTableShowExplanationState();
}

class _TruthTableShowExplanationState extends State<TruthTableShowExplanation> {
  final ScrollController _scrollController = ScrollController();
  final InstanceDeductionConclusion exampleDeduction =
      InstanceDeductionConclusion(
    name: 'Modus Ponens',
    premises: ['A -> B', 'A'],
    conclusion: 'B',
    isCorrect: true,
    colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 1, 1, 1))],
    explanation: ['This is the Modus ponens rule'],
  );

  @override

  /// Show a text with explanation of what is a truth table in logic
  Widget build(BuildContext context) {
    // Obtendo o idioma selecionado do provedor
    final List<String> truthTableExplanationTranslations = [
      // Árabe
      "متغير في صيغة منطقية يمكن أن يكون إما T (صحيح) أو F (خاطئ). \n تُستخدم جدول الحقيقة لربط جميع التركيبات الممكنة لقيم الحقيقة للمتغيرات بالقيمة التي تفترضها الصيغة (أو مجموعة من الصيغ). مع متغيرين، هناك 4 تركيبات ممكنة لقيم الحقيقة، كل واحدة ممثلة في صف في جدول الحقيقة. في جدول الحقيقة أدناه، يمثل الصف الأول الحالة عندما تكون A و \$A \\to B\$ صحيحتين (T). في هذه الحالة، تكون قيمة الصيغة \$B\\:\$ صحيحة أيضًا (T).",

      // Mandarim
      "一个逻辑公式的变量可以是T（真）或F（假）。\n真值表用于将变量的所有真值组合映射到公式的值（或一组公式）。对于2个变量，存在4种可能的真值组合，每种组合都由真值表中的一行表示。在下面的真值表中，第一行表示当A和\$A \\to B\$都为真（T）时的情况。在这种情况下，公式\$B\\:\$的值也为真（T）。",

      // Alemão
      "Eine Variable einer logischen Formel kann entweder T (wahr) oder F (falsch) sein. \n Eine Wahrheitstabelle wird verwendet, um alle Kombinationen von Wahrheitswerten der Variablen auf den Wert abzubilden, den eine Formel (oder eine Menge von Formeln) annimmt. Bei 2 Variablen gibt es 4 mögliche Kombinationen von Wahrheitswerten, die jeweils durch eine Zeile in der Wahrheitstabelle dargestellt werden. In der untenstehenden Wahrheitstabelle stellt die erste Zeile den Fall dar, wenn A und \$A \\to B\$ beide wahr (T) sind. In diesem Fall ist auch der Wert der Formel \$B\\:\$ wahr (T).",

      // Inglês
      "A variable of a logical formula can be either T (true) or F (false). \n A truth table is used to map all combinations of truth values of variables to the value assumed by a formula (or set of formulas). With 2 variables, there are 4 possible combinations of truth values, each one represented by a row in the truth table. In the truth table below, the first row represents the case when A and \$A \\to B\$ are both true (T). In this case, the value of the formula \$B\\:\$ is also true (T).",

      // Francês
      "Une variable d'une formule logique peut être soit T (vrai) soit F (faux). \n Une table de vérité est utilisée pour mapper toutes les combinaisons de valeurs de vérité des variables à la valeur supposée par une formule (ou un ensemble de formules). Avec 2 variables, il existe 4 combinaisons possibles de valeurs de vérité, chacune représentée par une ligne dans la table de vérité. Dans la table de vérité ci-dessous, la première ligne représente le cas où A et \$A \\to B\$ sont tous deux vrais (T). Dans ce cas, la valeur de la formule \$B\\:\$ est également vraie (T).",

      // Hindi
      "एक तार्किक सूत्र का वेरिएबल या तो T (सही) या F (गलत) हो सकता है।\n सत्य सारणी का उपयोग सभी संयोजनों को मैप करने के लिए किया जाता है। सूत्रों के सत्य मानों के संयोजन को सूत्र (या सूत्रों के सेट) द्वारा मानित मान के साथ। 2 वेरिएबल्स के साथ, सत्य मानों के 4 संभावित संयोजन होते हैं, जो प्रत्येक सत्य सारणी की एक पंक्ति द्वारा दर्शाए जाते हैं। नीचे सत्य सारणी में, पहली पंक्ति वह स्थिति दर्शाती है जब A और \$A \\to B\$ दोनों सही (T) हैं। इस स्थिति में, सूत्र \$B\\:\$ का मान भी सही (T) है।",

      // Japonês
      "論理式の変数は、T（真）またはF（偽）である可能性があります。\n 真理値表は、変数のすべての真理値の組み合わせを、式（または式のセット）によって仮定される値にマッピングするために使用されます。 2つの変数の場合、真理値の4つの可能な組み合わせがあり、それぞれが真理値表の行で表されます。 下の真理値表では、最初の行はAと\$A \\to B\$の両方が真（T）である場合を示しています。この場合、式\$B\\:\$の値も真（T）です。",

      // Português
      "Uma variável de uma fórmula lógica pode ser T (verdadeiro) ou F (falso). \n Uma tabela verdade é usada para mapear todas as combinações de valores de verdade das variáveis para o valor assumido por uma fórmula (ou conjunto de fórmulas). Com 2 variáveis, há 4 combinações possíveis de valores de verdade, cada uma representada por uma linha na tabela verdade. Na tabela verdade abaixo, a primeira linha representa o caso em que A e \$A \\to B\$ são ambos verdadeiros (T). Nesse caso, o valor da fórmula \$B\\:\$ também é verdadeiro (T).",

      // Espanhol
      "Una variable de una fórmula lógica puede ser T (verdadero) o F (falso). \n Una tabla de verdad se usa para mapear todas las combinaciones de valores de verdad de las variables al valor asumido por una fórmula (o conjunto de fórmulas). Con 2 variables, hay 4 combinaciones posibles de valores de verdad, cada una representada por una fila en la tabla de verdad. En la tabla de verdad a continuación, la primera fila representa el caso en el que A y \$A \\to B\$ son ambos verdaderos (T). En este caso, el valor de la fórmula \$B\\:\$ también es verdadero (T).",
    ];

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Se o índice do idioma for válido, use a tradução correta
        // Default to English if invalid index

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              myLatex(
                truthTableExplanationTranslations[
                    languageProvider.currentLanguageIndex],
                widget.fontSizeExplanation,
              ),
              const SizedBox(height: 30),
              truthTableFormulaList(
                exampleDeduction.premises,
                [exampleDeduction.conclusion],
                colorSquareList: [],
                fontSize: FontSizes(context).extraExtraExtraSmall,
                premiseValuesColor: Colors.transparent,
                premisesColor: Colors.transparent,
                conclusionColor: Colors.transparent,
                backgroundTableColor: Colors.amber[50],
                extraHeight: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}

class FormalDeduction extends StatefulWidget {
  const FormalDeduction({super.key, required this.fontSizeExplanation});
  final double fontSizeExplanation;
  @override
  State<FormalDeduction> createState() => _FormalDeductionState();
}

class _FormalDeductionState extends State<FormalDeduction> {
  final InstanceDeductionConclusion exampleDeduction =
      InstanceDeductionConclusion(
    name: 'Modus ponens',
    premises: ['A', 'A -> B'],
    conclusion: 'B',
    explanation: ['This is the Modus ponens rule'],
  );

  final List<String> deductionPremisesAndConclusionTranslations = [
    // Árabe
    "يعني أن \$A\$ و \$A \\to B\$ هما الفرضيات و \$B\\:\$ هو الاستنتاج. أي أنه كلما كانت الفرضيات صحيحة، فإن الاستنتاج يكون أيضًا صحيحًا.",
    // Mandarim
    "这意味着 \$A\$ 和 \$A \\to B\$ 是前提，而 \$B\\:\$ 是结论。也就是说，每当前提为真时，结论也为真。",
    // Alemão
    "Das bedeutet, dass \$A\$ und \$A \\to B\$ die Prämissen sind und \$B\\:\$ die Schlussfolgerung ist. Das heißt, wann immer die Prämissen wahr sind, ist auch die Schlussfolgerung wahr.",
    // Inglês
    "This means that \$A\$ and \$A \\to B\$ are the premises, and \$B\\:\$ is the conclusion. That is, whenever the premises are true, the conclusion is also true.",
    // Francês
    "Cela signifie que \$A\$ et \$A \\to B\$ sont les prémisses et \$B\\:\$ est la conclusion. C'est-à-dire que chaque fois que les prémisses sont vraies, la conclusion est également vraie.",
    // Hindi
    "इसका मतलब है कि \$A\$ और \$A \\to B\$ प्रस्तावनाएँ हैं और \$B\\:\$ निष्कर्ष है। अर्थात, जब भी प्रस्तावनाएँ सत्य होती हैं, निष्कर्ष भी सत्य होता है।",
    // Japonês
    "これは、\$A\$ と \$A \\to B\$ が前提であり、\$B\\:\$ が結論であることを意味します。つまり、前提が真であるとき、結論も真であるということです。",
    // Português
    "Isso significa que \$A\$ e \$A \\to B\$ são as premissas, e \$B\\:\$ é a conclusão. Ou seja, sempre que as premissas forem verdadeiras, a conclusão também será verdadeira.",
    // Espanhol
    "Esto significa que \$A\$ y \$A \\to B\$ son las premisas, y \$B\\:\$ es la conclusión. Es decir, siempre que las premisas sean verdaderas, la conclusión también será verdadera.",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  theSymbolsTranslations[languageProvider.currentLanguageIndex],
                  style: TextStyle(fontSize: widget.fontSizeExplanation),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deductionFromPremises(
                      exampleDeduction,
                      fontSize: widget.fontSizeExplanation - 2,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                myLatex(
                  deductionPremisesAndConclusionTranslations[
                      languageProvider.currentLanguageIndex],
                  widget.fontSizeExplanation,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
