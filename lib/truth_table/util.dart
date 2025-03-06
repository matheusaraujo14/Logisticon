import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

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

String removeExtraSpaces(String str) {
  str = str.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// replace ### por \r\n. For now, it is not necessary
  str = str.replaceAll('###', '\r\n');
  return str;
}

List<String> listremoveExtraSpaces(List<String> list) {
  // Aplica a limpeza de espaços em cada string da lista
  return list.map((str) {
    str = str.replaceAll(RegExp(r'\s+'), ' ').trim();
    // Substitui '###' por '\r\n', se necessário
    str = str.replaceAll('###', '\r\n');
    return str;
  }).toList();
}

/// The parameter latexStr contains text with LaTeX code between $...$. Separate the text
/// from the latex code. For the text, use the Text widget. For the LaTeX code, use the
/// LaTexT widget. Wrap everything in a Wrap widget.
Widget myLatex(
  String latexStr,
  double fontSize, {
  double textStyleHeight = 1.0,
}) {
  var latexList = removeExtraSpaces(latexStr).split(RegExp(r'\$'));
  var spaceBetweenWords = fontSize / 3;
  var spaceBetweenLines = fontSize / 1.5;
  //print('spaceBetweenWords: $spaceBetweenWords');
  var widgets = <Widget>[];
  for (var i = 0; i < latexList.length; i++) {
    if (i % 2 == 0) {
      var parts = latexList[i].split(' ');
      for (var j = 0; j < parts.length; j++) {
        if (parts[j].isNotEmpty) {
          widgets.add(Text(
            parts[j],
            style: TextStyle(
              fontSize: fontSize,
              height: textStyleHeight,
            ),
          ));
          // if (j < parts.length - 2) {
          //   widgets.add(SizedBox(width: spaceBetweenWords));
          // }
        }
      }
    } else {
      //widgets.add(SizedBox(width: spaceBetweenWords));
      widgets.add(LaTexT(
        breakDelimiter: '%',
        laTeXCode: Text(
          '\$${latexList[i]}\$',
          style: TextStyle(
            fontSize: fontSize - 2,
            height: textStyleHeight,
          ),
        ),
      ));
      //widgets.add(SizedBox(width: spaceBetweenWords));
    }
  }
  return Wrap(
    spacing: spaceBetweenLines,
    runSpacing: spaceBetweenWords,
    children: widgets,
  );
}
