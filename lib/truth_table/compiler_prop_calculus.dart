import 'package:new_test/truth_table/ast.dart';

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

double sizeFormula(String formulaStr) {
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
        break;
      case '^':
        size += basicSize;
        break;
      case '~':
        size += basicSize;
        break;
      case '->':
        size += 10.0;
        break;
      default:

        /// single letter
        size += 10;
        break;
    }
  }
  return size;
}

String propositionaLanguageToEnglish(String formulaStr) {
  var s = formulaStr.trim();
  Formula formula = parseFormula(s);
  s = formula.toEnglish(true);
  return s;
}
