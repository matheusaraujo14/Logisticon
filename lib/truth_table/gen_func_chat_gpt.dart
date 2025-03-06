import 'package:new_test/truth_table/compiler_prop_calculus.dart';
import 'package:new_test/truth_table/instance_deduction.dart';

String generateFunctionForChatGPT(
    List<InstanceDeductionConclusion> deductionList) {
  var localDeductionNameList =
      deductionList.map((e) => e.name).toSet().toList();
  var out = '''
import 'package:logicon_chats_dart/generate.dart';

String generatePromptForDeduction(
    {required String deductionName,
    required String area,
    int numberOfExamples = 3}) {
  deductionName = deductionName
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');    
  switch (deductionName) { ''';

  for (var deductionName in localDeductionNameList) {
    var subDeductionList = deductionList
        .where((element) => element.name == deductionName)
        .toList();
    var premises = subDeductionList[0].premises.toSet().toList();
    var correctConclusions = subDeductionList
        .where((e) => e.isCorrect)
        .toList()
        .map((e) => propositionaLanguageToEnglish(e.conclusion))
        .toList()
        .toSet()
        .toList();
    var incorrectConclusions = subDeductionList
        .where((e) => !e.isCorrect)
        .toList()
        .map((e) => propositionaLanguageToEnglish(e.conclusion))
        .toList()
        .toSet()
        .toList();

    var premisesStr = '[ ';
    int size = premises.length;
    for (var elem in premises) {
      premisesStr += '\'${propositionaLanguageToEnglish(elem)}\'';
      if (--size > 0) premisesStr += ', ';
    }
    premisesStr += ' ]';
    var correctConclusionsStr = '[ ';
    size = correctConclusions.length;
    for (var elem in correctConclusions) {
      correctConclusionsStr += '\'$elem\'';
      if (--size > 0) correctConclusionsStr += ', ';
    }
    correctConclusionsStr += ' ]';
    var incorrectConclusionsStr = '[ ';
    size = incorrectConclusions.length;
    for (var elem in incorrectConclusions) {
      incorrectConclusionsStr += '\'$elem\'';
      if (--size > 0) incorrectConclusionsStr += ', ';
    }
    incorrectConclusionsStr += ' ]';

    out += '''
    case '$deductionName':
      return generatePromptForGeneralDeduction(
          deductionName: '$deductionName',
          premises: $premisesStr,
          conclusions: $correctConclusionsStr,
          incorrectConclusions: $incorrectConclusionsStr,
          area: area);
    ''';
  }
  out += '''
  }
  throw Exception('Unknown deduction name \$deductionName');
}

''';

  return out;
}

/// Generate a text like in the  file 'list of aristotelian syllogisms - with wrong answers.txt'
/// with the list of deductions, each one with premises, conclusions and incorrect conclusions.
String generateTextDeductions(List<InstanceDeductionConclusion> deductionList) {
  var localDeductionNameList =
      deductionList.map((e) => e.name).toSet().toList();
  var out = '';

  for (var deductionName in localDeductionNameList) {
    var subDeductionList = deductionList
        .where((element) => element.name == deductionName)
        .toList();
    var premises = subDeductionList[0].premises.toSet().toList();
    var correctConclusions = subDeductionList
        .where((e) => e.isCorrect)
        .toList()
        .map((e) => propositionaLanguageToEnglish(e.conclusion))
        .toList()
        .toSet()
        .toList();
    var incorrectConclusions = subDeductionList
        .where((e) => !e.isCorrect)
        .toList()
        .map((e) => propositionaLanguageToEnglish(e.conclusion))
        .toList()
        .toSet()
        .toList();

    var premisesStr = '';
    for (var elem in premises) {
      premisesStr += '        ${propositionaLanguageToEnglish(elem)}\n';
    }
    var correctConclusionsStr = '';
    for (var elem in correctConclusions) {
      correctConclusionsStr += '        $elem\n';
    }
    correctConclusionsStr += '';
    var incorrectConclusionsStr = '';
    for (var elem in incorrectConclusions) {
      incorrectConclusionsStr += '        $elem\n';
    }

    var deductionWordList = deductionName.split(' ');
    if (deductionWordList.length > 1) {
      deductionName = deductionWordList[0];
      for (int i = 1; i < deductionWordList.length; ++i) {
        deductionName += ' ';
        deductionName += deductionWordList[i][0].toLowerCase() +
            deductionWordList[i].substring(1);
      }
    }
    out += '$deductionName\n';
    out += '    premises: \n$premisesStr';
    out += '    conclusions: \n$correctConclusionsStr';
    out += '    incorrect conclusions: \n$incorrectConclusionsStr\n\n';
  }

  return out;
}
