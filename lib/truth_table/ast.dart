import 'package:new_test/truth_table/compiler_prop_calculus.dart';

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

  String toEnglish(bool topMostFormula);
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

  @override
  String toEnglish(bool topMostFormula) {
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

  @override
  String toEnglish(bool topMostFormula) {
    return 'not ${formula.toEnglish(false)}';
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

  @override
  String toEnglish(bool topMostFormula) {
    String s;
    if (op == TokenType.ImpliesOperator) {
      s = 'If ${left.toEnglish(false)}, then ${right.toEnglish(false)}';
    } else if (op == TokenType.BiconditionalOperator) {
      s = '${left.toEnglish(false)} if and only if ${right.toEnglish(false)}';
    } else {
      s = switch (op) {
        TokenType.AndOperator =>
          '${left.toEnglish(false)} and ${right.toEnglish(false)}',
        TokenType.OrOperator =>
          '${left.toEnglish(false)} or ${right.toEnglish(false)}',
        _ => throw 'Unknown operator: ${op.name}',
      };
    }

    if (topMostFormula) {
      return s;
    } else {
      return '($s)';
    }
  }
}
