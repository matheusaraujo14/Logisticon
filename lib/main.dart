import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:new_test/data.dart';
import 'package:new_test/show_questions.dart';
import 'package:new_test/start_page.dart';
import 'package:new_test/show_history.dart';
import 'package:new_test/show_explanation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:new_test/choose_language.dart';
import 'package:new_test/truth_table/edit_table.dart';
import 'package:new_test/font_size.dart';
import 'package:provider/provider.dart';
import 'package:new_test/show_explanation_deduction.dart';
import 'global_language.dart';
// import 'package:new_test/timer.dart';

late Map<String, dynamic> mapFileToContents;
final List<Question> questions = [];
late double percentCorrectAnswers;
late int numberOfCorrectAnswers;
late int numberOfQuestions;
late int correctAnswersInARow;
late int bestCombo;
late Map<String, dynamic> currentQuestion;

String lastSyllType = 'none';
late TypeOfQuestion lastSyllTypeOfQuestion;
List<Widget> options = [];
List<String> randomOptions = [];
TypeOfQuestion type = TypeOfQuestion.syllogism;
Map<String, dynamic>? lastSyllogism = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fixando a orientação na horizontal
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  Future<Map<String, dynamic>> tempLib = readJson(3); // ingles
  mapFileToContents = await tempLib;

  runApp(
    ChangeNotifierProvider(
      // Cria o LanguageProvider com o índice de idioma inicial
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(
        gameActive: false,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<Map<String, dynamic>> readJson(int index) async {
  // Lista dos arquivos de assets, substitua pelos caminhos reais
  const syllPaths = [
    'assets/all-languages-syllogism/arb-syllogism.json',
    'assets/all-languages-syllogism/cmn-syllogism.json',
    'assets/all-languages-syllogism/deu-syllogism.json',
    'assets/all-languages-syllogism/eng-syllogism.json',
    'assets/all-languages-syllogism/fra-syllogism.json',
    'assets/all-languages-syllogism/hin-syllogism.json',
    'assets/all-languages-syllogism/jpn-syllogism.json',
    'assets/all-languages-syllogism/por-syllogism.json',
    'assets/all-languages-syllogism/spa-syllogism.json'
  ];
  const deducPaths = [
    'assets/all-languages-deductions/arb-deductions.json',
    'assets/all-languages-deductions/cmn-deductions.json',
    'assets/all-languages-deductions/deu-deductions.json',
    'assets/all-languages-deductions/eng-deductions.json',
    'assets/all-languages-deductions/fra-deductions.json',
    'assets/all-languages-deductions/hin-deductions.json',
    'assets/all-languages-deductions/jpn-deductions.json',
    'assets/all-languages-deductions/por-deductions.json',
    'assets/all-languages-deductions/spa-deductions.json'
  ];

  dynamic allData = {};
  String response = '';
  Map<String, dynamic> decodedData = {};

  // Obter o arquivo syllogism correspondente ao índice
  response = await rootBundle.loadString(syllPaths[index]);
  decodedData = json.decode(response);
  for (int i = 0; i < decodedData.keys.length; i++) {
    String key = decodedData.keys.elementAt(i);
    for (int j = 0; j < decodedData[key].length; j++) {
      String syllogism = decodedData[key][j].keys.first;
      for (int k = 0; k < decodedData[key][j][syllogism].length; k++) {
        if (!allData.containsKey(key)) {
          allData[key] = {};
        }
        if (!allData[key].containsKey(syllogism)) {
          allData[key][syllogism] = {};
        }
        allData[key][syllogism][k] = decodedData[key][j][syllogism][k];
      }
    }
  }

  // Obter o arquivo deduction correspondente ao índice
  response = await rootBundle.loadString(deducPaths[index]);
  decodedData = json.decode(response);
  for (int i = 0; i < decodedData.keys.length; i++) {
    String key = decodedData.keys.elementAt(i);
    for (int j = 0; j < decodedData[key].length; j++) {
      String deduction = decodedData[key][j].keys.first;
      for (int k = 0; k < decodedData[key][j][deduction].length; k++) {
        if (!allData.containsKey(key)) {
          allData[key] = {};
        }
        if (!allData[key].containsKey(deduction)) {
          allData[key][deduction] = {};
        }
        allData[key][deduction][k] = decodedData[key][j][deduction][k];
      }
    }
  }

  allData = Map<String, dynamic>.from(allData);
  return allData;
}

List<String> getLanguagesCode() {
  const syllPaths = [
    'assets/all-languages-syllogism/arb-syllogism.json',
    'assets/all-languages-syllogism/cmn-syllogism.json',
    'assets/all-languages-syllogism/deu-syllogism.json',
    'assets/all-languages-syllogism/eng-syllogism.json',
    'assets/all-languages-syllogism/fra-syllogism.json',
    'assets/all-languages-syllogism/hin-syllogism.json',
    'assets/all-languages-syllogism/jpn-syllogism.json',
    'assets/all-languages-syllogism/por-syllogism.json',
    'assets/all-languages-syllogism/spa-syllogism.json',
  ];

  List<String> languages = [];
  for (String path in syllPaths) {
    String fileName = path.split('/').last; // Obtém o nome do arquivo
    String languageCode =
        fileName.split('-').first; // Extrai o código do idioma
    if (!languages.contains(languageCode)) {
      languages.add(languageCode); // Evita duplicatas
    }
  }
  return languages;
}

class LogicalApp extends StatelessWidget {
  final bool gameActive;

  LogicalApp({
    super.key,
    required this.gameActive,
  });

  // This widget is the root of your application.cd
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syllogism question',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(199, 0, 255, 255),
        ),
        useMaterial3: true,
      ),
      home: MyLogicalApp(
        gameActive: gameActive,
      ),
    );
  }
}

class MyLogicalApp extends StatefulWidget {
  final bool gameActive;

  MyLogicalApp({
    super.key,
    required this.gameActive,
  });

  @override
  State<MyLogicalApp> createState() => MyLogicalAppState();
}

void clearQuestions() {
  questions.clear();
}

class MyLogicalAppState extends State<MyLogicalApp> {
  @override
  Widget build(BuildContext context) {
    FontSizes fontSizes = FontSizes(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double size = screenHeight > screenWidth ? screenHeight : screenWidth;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          // botoes de mmudar a lingua e de reportar questão na appbar

          /* title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
            int index = languageProvider.currentLanguageIndex;
            return SizedBox(
              child: Row(
                children: [
                  // botao de alterar idioma
                  IconButton(
                    icon: Icon(Icons.language, size: fontSizes.extraLarge),
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey.shade200,
                            title: SelectableText(
                              chooseOptionTranslations[index]!,
                              style: TextStyle(
                                fontSize: fontSizes.large,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content:
                                ChooseLanguage(languages: getLanguagesCode()),
                          );
                        },
                      ).then(
                        (value) {
                          if (value != null) {
                            
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                  // botao de reportar questão
                  IconButton(
                    tooltip: show_history_reportQuestionTranslations[index],
                    iconSize: fontSizes.extraLarge,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.yellow.shade800,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.yellow.shade500,
                              alignment: Alignment.center,
                              actionsAlignment: MainAxisAlignment.center,
                              content: SelectableText(
                                  show_history_reportQuestionTranslations[
                                      index],
                                  style: TextStyle(
                                      fontSize: screenWidth > screenHeight
                                          ? FontSizes(context).large
                                          : FontSizes(context).medium,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                          show_history_closeTranslations[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  FontSizes(context).medium,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Implementar a função de reportar
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 2500), () {
                                              Navigator.of(context).pop();
                                            });
                                            return AlertDialog(
                                              backgroundColor: Colors.red,
                                              title: SelectableText(
                                                  show_history_thanksForYourReportTranslations[
                                                      index],
                                                  style: TextStyle(
                                                      fontSize:
                                                          FontSizes(context)
                                                              .large,
                                                      color: Colors.yellow,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                          show_history_reportTranslations[
                                              index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  FontSizes(context).medium,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            );
          }), */
          leading: Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              int index = languageProvider.currentLanguageIndex;
              return IconButton(
                icon: Icon(Icons.arrow_back, size: fontSizes.extraLarge),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StartPage(
                              gameActive: true,
                            )),
                  );
                },
                tooltip: backTranslations[index],
              );
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
            size: fontSizes.extraLarge,
          ),
        ),
        body: ShowQuestionList(
          gameActive: widget.gameActive,
        ),
      ),
    );
  }
}

// create a ShowQuestionList statefull widget
class ShowQuestionList extends StatefulWidget {
  final bool gameActive;
  ShowQuestionList({
    super.key,
    required this.gameActive,
  });

  @override
  State<ShowQuestionList> createState() => ShowQuestionListState();
}

enum AnswerQuestion { correct, incorrect, notAnswered }

class ShowQuestionListState extends State<ShowQuestionList> {
  ValueNotifier<List<String>> chosedOption = ValueNotifier<List<String>>(['']);
  ValueNotifier<String> syllogismType = ValueNotifier<String>('none');
  ValueNotifier<AnswerQuestion> answer =
      ValueNotifier<AnswerQuestion>(AnswerQuestion.notAnswered);
  ValueNotifier<String> majorPremise = ValueNotifier<String>('none');
  ValueNotifier<String> minorPremise = ValueNotifier<String>('none');
  ValueNotifier<String> conclusion = ValueNotifier<String>('none');
  ValueNotifier<List<dynamic>> premises = ValueNotifier<List<dynamic>>(['']);
  ValueNotifier<List<String>> conclusions = ValueNotifier<List<String>>(['']);
  ValueNotifier<TypeOfQuestion> typeOfQuestion =
      ValueNotifier<TypeOfQuestion>(TypeOfQuestion.syllogism);
  ValueNotifier<List<String>> incorrectConclusions =
      ValueNotifier<List<String>>(['']);
  ValueNotifier<List<int>> selectedCorrectOptions =
      ValueNotifier<List<int>>([]);
  ValueNotifier<List<int>> selectedIncorrectOptions =
      ValueNotifier<List<int>>([]);
  ValueNotifier<List<int>> selectedOptionsInOrder =
      ValueNotifier<List<int>>([]);

  bool alternativeText = true;
  @override
  void initState() {
    if (syllogismType.value == 'none' && lastSyllType != 'none') {
      syllogismType.value = lastSyllType;
      typeOfQuestion.value = lastSyllTypeOfQuestion;
      currentQuestion = changedLanguage ? _randomQuestion() : lastSyllogism!;
    }
    super.initState();
    if (!widget.gameActive) {
      numberOfCorrectAnswers = 0;
      numberOfQuestions = 0;
      correctAnswersInARow = 0;
      bestCombo = 0;
      percentCorrectAnswers = 0;
      currentQuestion = _randomQuestion();
    }
    changedLanguage = false;
  }

  void nextQuestion() {
    setState(() {
      chosedOption.value.clear();
      chosedOption.value.add('');
      answer.value = AnswerQuestion.notAnswered;
      currentQuestion = _randomQuestion();
      lastSyllogism = currentQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenSize = screenHeight > screenWidth ? screenHeight : screenWidth;
    FontSizes fontSizes = FontSizes(context);

    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      int currentLanguageIndex = languageProvider.currentLanguageIndex;
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 113, 252, 194),
                Color.fromARGB(255, 6, 231, 126),
                //Color.fromARGB(255, 255, 255, 255),
              ]),
          color: Colors.white,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          lastSyllType = syllogismType.value == 'none'
              ? lastSyllType
              : syllogismType.value;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Column(
              key: ValueKey<int>(numberOfQuestions),
              children: [
                Expanded(
                  flex: screenWidth > screenHeight ? 15 : 50,
                  child: SizedBox(
                    child: ShowQuestion(
                      syllogism: currentQuestion,
                      chosedOption: chosedOption,
                      answer: answer,
                      syllogismType: syllogismType,
                      majorPremise: majorPremise,
                      minorPremise: minorPremise,
                      conclusion: conclusion,
                      premises: premises,
                      conclusions: conclusions,
                      typeOfQuestion: typeOfQuestion,
                      incorrectConclusions: incorrectConclusions,
                      selectedCorrectOptions: selectedCorrectOptions,
                      selectedIncorrectOptions: selectedIncorrectOptions,
                      selectedOptionsInOrder: selectedOptionsInOrder,
                    ),
                  ),
                ),
                if (screenWidth > screenHeight) ...[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: numberOfCorrectAnswers >=
                                          numberOfQuestions / 2 &&
                                      numberOfQuestions > 0
                                  ? Colors.green
                                  : numberOfQuestions == 0
                                      ? Colors.grey
                                      : Colors.redAccent,
                              width: 5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: numberOfCorrectAnswers >=
                                            numberOfQuestions / 2 &&
                                        numberOfQuestions > 0
                                    ? correctAnswersInARow >= 20
                                        ? Colors.purple
                                        : correctAnswersInARow >= 15
                                            ? Colors.blue
                                            : correctAnswersInARow >= 10
                                                ? const Color.fromARGB(
                                                    255, 207, 187, 0)
                                                : Colors.lightGreen
                                    : numberOfQuestions == 0
                                        ? Colors.grey
                                        : Colors.redAccent,
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: screenWidth * 0.16,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SelectableText(
                                        '$numberOfCorrectAnswers/$numberOfQuestions ',
                                        style: TextStyle(
                                          fontSize: fontSizes.extraSmall,
                                          color: numberOfCorrectAnswers >=
                                                      numberOfQuestions / 2 &&
                                                  numberOfQuestions > 0
                                              ? Colors.green
                                              : numberOfQuestions == 0
                                                  ? Colors.grey.shade800
                                                  : Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (numberOfQuestions > 0)
                                        SelectableText(
                                          '${(100 * percentCorrectAnswers).truncate()}% ${main_correctTranslations[currentLanguageIndex]}',
                                          style: TextStyle(
                                            fontSize:
                                                FontSizes(context).extraSmall,
                                            color: numberOfCorrectAnswers >=
                                                    numberOfQuestions / 2
                                                ? Colors.green
                                                : numberOfQuestions == 0
                                                    ? Colors.grey.shade800
                                                    : Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (numberOfQuestions == 0)
                                        SelectableText(
                                          '-% ${main_correctTranslations[currentLanguageIndex]}',
                                          style: TextStyle(
                                            fontSize:
                                                FontSizes(context).extraSmall,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    SelectableText(
                                      '${main_currentComboTranslations[currentLanguageIndex]} $correctAnswersInARow',
                                      style: TextStyle(
                                          fontSize: fontSizes.extraExtraSmall,
                                          fontWeight: FontWeight.bold,
                                          color: correctAnswersInARow >= 20
                                              ? Colors.purple
                                              : correctAnswersInARow >= 15
                                                  ? Colors.blue
                                                  : correctAnswersInARow >= 10
                                                      ? const Color.fromARGB(
                                                          255, 207, 187, 0)
                                                      : correctAnswersInARow >=
                                                              5
                                                          ? Colors.lightGreen
                                                          : Colors
                                                              .grey.shade700),
                                    ),
                                    SelectableText(
                                      '${main_yourBestTranslations[currentLanguageIndex]} $bestCombo',
                                      style: TextStyle(
                                        fontSize: fontSizes.extraExtraSmall,
                                        fontWeight: FontWeight.bold,
                                        color: bestCombo >= 20
                                            ? Colors.purple
                                            : bestCombo >= 15
                                                ? Colors.blue
                                                : bestCombo >= 10
                                                    ? const Color.fromARGB(
                                                        255, 207, 187, 0)
                                                    : bestCombo >= 5
                                                        ? Colors.lightGreen
                                                        : Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //const Spacer(),
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 10, 192, 122),
                                  blurRadius: 15,
                                  offset: const Offset(5, 5),
                                )
                              ]),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              elevation: 10,
                              shadowColor:
                                  const Color.fromARGB(255, 4, 128, 80),
                            ),
                            onPressed: () {
                              if (chosedOption.value.first == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: SelectableText("Atenção",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: fontSizes.medium)),
                                      content: SelectableText(
                                          "Você deve selecionar uma das opções ou pular a questão.",
                                          style: TextStyle(
                                              fontSize: fontSizes.small)),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha a janela
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.lightBlue,
                                            foregroundColor: Colors.white,
                                            fixedSize: Size(screenWidth * 0.1,
                                                FontSizes(context).extraLarge),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Text("Entendido",
                                              style: TextStyle(
                                                  fontSize:
                                                      fontSizes.extraSmall)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return; // Interrompe o restante do processamento
                              }

                              bool error = verifyError(
                                conclusion.value,
                                chosedOption.value.first,
                                chosedOption.value,
                                incorrectConclusions.value,
                                conclusions.value,
                                typeOfQuestion.value,
                              );

                              Widget msg;
                              if (!error) {
                                if (answer.value == AnswerQuestion.correct) {
                                  msg = SelectableText(
                                    main_correctAnswerTranslations[
                                        currentLanguageIndex],
                                    style: TextStyle(
                                        fontSize:
                                            fontSizes.extraExtraExtraSmall),
                                  );
                                } else if (answer.value ==
                                    AnswerQuestion.incorrect) {
                                  msg = SelectableText(
                                    main_incorrectAnswerTranslations[
                                        currentLanguageIndex],
                                    style: TextStyle(
                                        fontSize:
                                            fontSizes.extraExtraExtraSmall),
                                  );
                                } else {
                                  msg = SelectableText(
                                    main_notAnsweredTranslations[
                                        currentLanguageIndex],
                                    style: TextStyle(
                                        fontSize:
                                            fontSizes.extraExtraExtraSmall),
                                  );
                                }
                              } else {
                                msg = SelectableText(
                                  main_errorTranslations[currentLanguageIndex],
                                  style: TextStyle(
                                      fontSize: fontSizes.extraExtraExtraSmall),
                                );
                              }
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: msg,
                                  duration: const Duration(milliseconds: 800),
                                  backgroundColor: error
                                      ? const Color.fromARGB(255, 192, 173, 0)
                                      : answer.value == AnswerQuestion.correct
                                          ? Colors.green
                                          : answer.value ==
                                                  AnswerQuestion.notAnswered
                                              ? Colors.grey
                                              : Colors.red,
                                ),
                              );

                              if (!error) {
                                if (answer.value == AnswerQuestion.correct) {
                                  ++numberOfCorrectAnswers;
                                }
                                ++numberOfQuestions;
                                percentCorrectAnswers =
                                    numberOfCorrectAnswers / numberOfQuestions;

                                answer.value != AnswerQuestion.correct
                                    ? correctAnswersInARow = 0
                                    : ++correctAnswersInARow;

                                if (correctAnswersInARow > bestCombo) {
                                  bestCombo = correctAnswersInARow;
                                }
                              }

                              questions.add(Question(
                                  userChoices: chosedOption.value.toList(),
                                  syllogismType: syllogismType.value,
                                  majorPremise: majorPremise.value,
                                  minorPremise: minorPremise.value,
                                  userChoice: chosedOption.value.first,
                                  rightChoice: conclusion.value,
                                  premises: premises.value,
                                  isCorrect: answer.value,
                                  typeOfQuestion: typeOfQuestion.value,
                                  conclusions: conclusions.value,
                                  incorrectConclusions:
                                      incorrectConclusions.value,
                                  selectedCorrectOptions:
                                      selectedCorrectOptions.value,
                                  selectedIncorrectOptions:
                                      selectedIncorrectOptions.value,
                                  selectedOptionsInOrder:
                                      selectedOptionsInOrder.value));

                              nextQuestion();
                              setState(() {});
                            },
                            child: Text(
                              textAlign: TextAlign.center,
                              main_verifyTranslations[currentLanguageIndex],
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: fontSizes.extraExtraExtraLarge,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                        //const Spacer(),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: screenWidth * 0.16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 29, 169, 108),
                                    width: 5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                            255, 3, 83, 75),
                                        offset: Offset(2, 3),
                                        blurRadius: 3,
                                        spreadRadius: 2),
                                  ],
                                ),
                                child: IconButton(
                                  tooltip: show_history_explicacaoTranslations[
                                      currentLanguageIndex],
                                  hoverColor: Colors.grey.shade300,
                                  focusColor: Colors.grey.shade300,
                                  iconSize: screenSize * 0.055,
                                  icon: const Icon(Icons.lightbulb_circle,
                                      color: const Color.fromARGB(
                                          255, 29, 169, 108)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.grey.shade200,
                                          title: SelectableText(
                                            premises.value.isEmpty
                                                ? main_explanationQuestionTranslations[
                                                    currentLanguageIndex]
                                                : main_explanationDeductionQuestionTranslations[
                                                    currentLanguageIndex],
                                            style: TextStyle(
                                                fontSize: fontSizes.medium),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // Botão NO
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                        main_noTranslations[
                                                            currentLanguageIndex],
                                                        style: TextStyle(
                                                            fontSize: fontSizes
                                                                .small)),
                                                  ),
                                                ),
                                                // Botão YES
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    alignment: Alignment.center,
                                                    backgroundColor:
                                                        Colors.lightBlue,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    //Navigator.of(context).pop();
                                                    if (typeOfQuestion.value ==
                                                        TypeOfQuestion
                                                            .syllogism) {
                                                      Navigator.of(context)
                                                          .pop();

                                                      showExplanation(
                                                        context,
                                                        syllogismType.value,
                                                        premises.value.isEmpty
                                                            ? true
                                                            : false,
                                                        selectedCorrectOptions
                                                            .value,
                                                        selectedIncorrectOptions
                                                            .value,
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showTestDeduction(context,
                                                          premises: premises,
                                                          conclusions:
                                                              conclusions,
                                                          incorrectConclusions:
                                                              incorrectConclusions,
                                                          selectedCorrectOptions:
                                                              selectedCorrectOptions,
                                                          selectedIncorrectOptions:
                                                              selectedIncorrectOptions,
                                                          sylogismType:
                                                              syllogismType
                                                                  .value,
                                                          selectedOptionsInOrder:
                                                              selectedCorrectOptions);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                        main_yesTranslations[
                                                            currentLanguageIndex],
                                                        style: TextStyle(
                                                            fontSize: fontSizes
                                                                .small)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 29, 169, 108),
                                    width: 5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 3, 83, 75),
                                      offset: Offset(2, 3),
                                      blurRadius: 3,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                  tooltip: main_historicoTranslations[
                                      currentLanguageIndex],
                                  hoverColor: Colors.grey.shade300,
                                  focusColor: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.history,
                                      color: const Color.fromARGB(
                                          255, 29, 169, 108)),
                                  iconSize: screenSize * 0.055,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.grey.shade200,
                                          title: SelectableText(
                                            main_historicoTranslations[
                                                currentLanguageIndex],
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: questions.isNotEmpty
                                              ? SizedBox(
                                                  height: 1000,
                                                  width: 750,
                                                  child: ShowHistory(
                                                      questions: questions))
                                              : SelectableText(
                                                  main_noQuestionsAnsweredYetTranslations[
                                                      currentLanguageIndex],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.lightBlue,
                                                foregroundColor: Colors.white,
                                                minimumSize:
                                                    const Size(100, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                child: Text(
                                                    main_okTranslations[
                                                        currentLanguageIndex],
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 29, 169, 108),
                                      width: 5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color.fromARGB(
                                              255, 3, 83, 75),
                                          offset: Offset(2, 3),
                                          blurRadius: 3,
                                          spreadRadius: 2),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: IconButton(
                                      tooltip: skipTranslations[
                                          currentLanguageIndex],
                                      hoverColor: Colors.grey.shade300,
                                      focusColor: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      icon: const Icon(
                                          Icons.arrow_circle_right_sharp,
                                          color: const Color.fromARGB(
                                              255, 29, 169, 108)),
                                      iconSize: screenSize * 0.055,
                                      onPressed: () {
                                        randomOptions.clear();
                                        nextQuestion();
                                        setState(() {});
                                      })),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Container(
                    // Botões de ação
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      // Coluna de botões
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                alternativeText = !alternativeText;
                              });
                            },
                            child: Container(
                              // Dados do usuário
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: numberOfCorrectAnswers >=
                                              numberOfQuestions / 2 &&
                                          numberOfQuestions > 0
                                      ? Colors.green
                                      : numberOfQuestions == 0
                                          ? Colors.grey
                                          : Colors.redAccent,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: numberOfCorrectAnswers >=
                                                numberOfQuestions / 2 &&
                                            numberOfQuestions > 0
                                        ? correctAnswersInARow >= 20
                                            ? Colors.purple
                                            : correctAnswersInARow >= 15
                                                ? Colors.blue
                                                : correctAnswersInARow >= 10
                                                    ? const Color.fromARGB(
                                                        255, 207, 187, 0)
                                                    : Colors.lightGreen
                                        : numberOfQuestions == 0
                                            ? Colors.grey
                                            : Colors.redAccent,
                                    blurRadius: 5,
                                    offset: const Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (alternativeText) ...[
                                        SelectableText(
                                          '$numberOfCorrectAnswers/$numberOfQuestions ',
                                          style: TextStyle(
                                            fontSize: fontSizes.small,
                                            color: numberOfCorrectAnswers >=
                                                        numberOfQuestions / 2 &&
                                                    numberOfQuestions > 0
                                                ? Colors.green
                                                : numberOfQuestions == 0
                                                    ? Colors.grey.shade800
                                                    : Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              alternativeText =
                                                  !alternativeText;
                                            });
                                          },
                                        ),
                                        if (numberOfQuestions > 0) ...[
                                          SelectableText(
                                            '${(100 * percentCorrectAnswers).truncate()}% ${main_correctTranslations[currentLanguageIndex]}',
                                            style: TextStyle(
                                              fontSize: fontSizes.small,
                                              color: numberOfCorrectAnswers >=
                                                      numberOfQuestions / 2
                                                  ? Colors.green
                                                  : numberOfQuestions == 0
                                                      ? Colors.grey.shade800
                                                      : Colors.redAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                alternativeText =
                                                    !alternativeText;
                                              });
                                            },
                                          ),
                                        ],
                                        if (numberOfQuestions == 0) ...[
                                          SelectableText(
                                            '-% ${main_correctTranslations[currentLanguageIndex]}',
                                            style: TextStyle(
                                              fontSize: fontSizes.small,
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                alternativeText =
                                                    !alternativeText;
                                              });
                                            },
                                          ),
                                        ]
                                      ] else ...[
                                        SelectableText(
                                          onTap: () {
                                            setState(() {
                                              alternativeText =
                                                  !alternativeText;
                                            });
                                          },
                                          '${main_currentComboTranslations[currentLanguageIndex]} $correctAnswersInARow',
                                          style: TextStyle(
                                              fontSize: fontSizes.extraSmall,
                                              fontWeight: FontWeight.bold,
                                              color: correctAnswersInARow >= 20
                                                  ? Colors.purple
                                                  : correctAnswersInARow >= 15
                                                      ? Colors.blue
                                                      : correctAnswersInARow >=
                                                              10
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 207, 187, 0)
                                                          : correctAnswersInARow >=
                                                                  5
                                                              ? Colors
                                                                  .lightGreen
                                                              : Colors.grey
                                                                  .shade700),
                                        ),
                                        SelectableText(
                                          onTap: () {
                                            setState(() {
                                              alternativeText =
                                                  !alternativeText;
                                            });
                                          },
                                          ' ${main_yourBestTranslations[currentLanguageIndex]} $bestCombo',
                                          style: TextStyle(
                                            fontSize: fontSizes.extraSmall,
                                            fontWeight: FontWeight.bold,
                                            color: bestCombo >= 20
                                                ? Colors.purple
                                                : bestCombo >= 15
                                                    ? Colors.blue
                                                    : bestCombo >= 10
                                                        ? const Color.fromARGB(
                                                            255, 207, 187, 0)
                                                        : bestCombo >= 5
                                                            ? Colors.lightGreen
                                                            : Colors
                                                                .grey.shade700,
                                          ),
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 29, 169, 108),
                                  width: 5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 3, 83, 75),
                                      offset: Offset(2, 3),
                                      blurRadius: 3,
                                      spreadRadius: 2),
                                ],
                              ),
                              child: IconButton(
                                tooltip: show_history_explicacaoTranslations[
                                    currentLanguageIndex],
                                hoverColor: Colors.grey.shade300,
                                focusColor: Colors.grey.shade300,
                                iconSize: screenSize * 0.055,
                                icon: const Icon(Icons.lightbulb_circle,
                                    color: const Color.fromARGB(
                                        255, 29, 169, 108)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.grey.shade200,
                                        title: SelectableText(
                                          premises.value.isEmpty
                                              ? main_explanationQuestionTranslations[
                                                  currentLanguageIndex]
                                              : main_explanationDeductionQuestionTranslations[
                                                  currentLanguageIndex],
                                          style: TextStyle(
                                              fontSize: fontSizes.medium),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Botão NO
                                              SizedBox(
                                                width: 75,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                    fixedSize: Size(
                                                        screenWidth * 0.075,
                                                        FontSizes(context)
                                                            .extraLarge),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                      main_noTranslations[
                                                          currentLanguageIndex],
                                                      style: TextStyle(
                                                          fontSize:
                                                              fontSizes.small)),
                                                ),
                                              ),
                                              // Botão YES
                                              SizedBox(
                                                width: 75,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    alignment: Alignment.center,
                                                    backgroundColor:
                                                        Colors.lightBlue,
                                                    foregroundColor:
                                                        Colors.white,
                                                    fixedSize: Size(
                                                        screenWidth * 0.075,
                                                        FontSizes(context)
                                                            .extraLarge),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    //Navigator.of(context).pop();
                                                    if (typeOfQuestion.value ==
                                                        TypeOfQuestion
                                                            .syllogism) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showExplanation(
                                                        context,
                                                        syllogismType.value,
                                                        premises.value.isEmpty
                                                            ? true
                                                            : false,
                                                        selectedCorrectOptions
                                                            .value,
                                                        selectedIncorrectOptions
                                                            .value,
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showTestDeduction(context,
                                                          premises: premises,
                                                          conclusions:
                                                              conclusions,
                                                          incorrectConclusions:
                                                              incorrectConclusions,
                                                          selectedCorrectOptions:
                                                              selectedCorrectOptions,
                                                          selectedIncorrectOptions:
                                                              selectedIncorrectOptions,
                                                          sylogismType:
                                                              syllogismType
                                                                  .value,
                                                          selectedOptionsInOrder:
                                                              selectedCorrectOptions);
                                                    }
                                                  },
                                                  child: Text(
                                                      main_yesTranslations[
                                                          currentLanguageIndex],
                                                      style: TextStyle(
                                                          fontSize:
                                                              fontSizes.small)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 29, 169, 108),
                                  width: 5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 3, 83, 75),
                                    offset: Offset(2, 3),
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: IconButton(
                                tooltip: main_historicoTranslations[
                                    currentLanguageIndex],
                                hoverColor: Colors.grey.shade300,
                                focusColor: Colors.grey.shade300,
                                alignment: Alignment.center,
                                icon: const Icon(Icons.history,
                                    color: const Color.fromARGB(
                                        255, 29, 169, 108)),
                                iconSize: screenSize * 0.055,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.grey.shade200,
                                        title: SelectableText(
                                          main_historicoTranslations[
                                              currentLanguageIndex],
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: questions.isNotEmpty
                                            ? SizedBox(
                                                height: 1000,
                                                width: 750,
                                                child: ShowHistory(
                                                    questions: questions))
                                            : SelectableText(
                                                main_noQuestionsAnsweredYetTranslations[
                                                    currentLanguageIndex],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 28),
                                              ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              foregroundColor: Colors.white,
                                              minimumSize: const Size(100, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                  main_okTranslations[
                                                      currentLanguageIndex],
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 29, 169, 108),
                                    width: 5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                            255, 3, 83, 75),
                                        offset: Offset(2, 3),
                                        blurRadius: 3,
                                        spreadRadius: 2),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                    tooltip:
                                        skipTranslations[currentLanguageIndex],
                                    hoverColor: Colors.grey.shade300,
                                    focusColor: Colors.grey.shade300,
                                    alignment: Alignment.center,
                                    icon: const Icon(
                                        Icons.arrow_circle_right_sharp,
                                        color: const Color.fromARGB(
                                            255, 29, 169, 108)),
                                    iconSize: screenSize * 0.055,
                                    onPressed: () {
                                      randomOptions.clear();
                                      nextQuestion();
                                      setState(() {});
                                    })),
                          ],
                        ),
                        //Spacer(),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 10, 192, 122),
                                  blurRadius: 15,
                                  offset: const Offset(5, 5),
                                )
                              ]),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              elevation: 10,
                              shadowColor:
                                  const Color.fromARGB(255, 4, 128, 80),
                            ),
                            onPressed: () {
                              if (chosedOption.value.first == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: SelectableText("Atenção",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: fontSizes.medium)),
                                      content: SelectableText(
                                          textAlign: TextAlign.center,
                                          "Você deve selecionar uma das opções ou pular a questão.",
                                          style: TextStyle(
                                              fontSize: fontSizes.small)),
                                      actions: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Fecha a janela
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              foregroundColor: Colors.white,
                                              fixedSize: Size(
                                                  screenWidth * 0.1,
                                                  FontSizes(context)
                                                      .extraLarge),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Text("Entendido",
                                                style: TextStyle(
                                                    fontSize:
                                                        fontSizes.extraSmall)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return; // Interrompe o restante do processamento
                              }
                              bool error = verifyError(
                                conclusion.value,
                                chosedOption.value.first,
                                chosedOption.value,
                                incorrectConclusions.value,
                                conclusions.value,
                                typeOfQuestion.value,
                              );

                              Widget msg;
                              if (!error) {
                                if (answer.value == AnswerQuestion.correct) {
                                  msg = SelectableText(
                                      main_correctAnswerTranslations[
                                          currentLanguageIndex],
                                      style: TextStyle(
                                          fontSize:
                                              fontSizes.extraExtraExtraSmall));
                                } else if (answer.value ==
                                    AnswerQuestion.incorrect) {
                                  msg = SelectableText(
                                      main_incorrectAnswerTranslations[
                                          currentLanguageIndex],
                                      style: TextStyle(
                                          fontSize:
                                              fontSizes.extraExtraExtraSmall));
                                } else {
                                  msg = SelectableText(
                                      main_notAnsweredTranslations[
                                          currentLanguageIndex],
                                      style: TextStyle(
                                          fontSize:
                                              fontSizes.extraExtraExtraSmall));
                                }
                              } else {
                                msg = SelectableText(
                                    main_errorTranslations[
                                        currentLanguageIndex],
                                    style: TextStyle(
                                        fontSize:
                                            fontSizes.extraExtraExtraSmall));
                              }
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: msg,
                                    duration: const Duration(milliseconds: 800),
                                    backgroundColor: error
                                        ? const Color.fromARGB(255, 192, 173, 0)
                                        : answer.value == AnswerQuestion.correct
                                            ? Colors.green
                                            : answer.value ==
                                                    AnswerQuestion.notAnswered
                                                ? Colors.grey
                                                : Colors.red),
                              );

                              if (!error) {
                                if (answer.value == AnswerQuestion.correct) {
                                  ++numberOfCorrectAnswers;
                                }
                                ++numberOfQuestions;
                                percentCorrectAnswers =
                                    numberOfCorrectAnswers / numberOfQuestions;

                                answer.value != AnswerQuestion.correct
                                    ? correctAnswersInARow = 0
                                    : ++correctAnswersInARow;

                                if (correctAnswersInARow > bestCombo) {
                                  bestCombo = correctAnswersInARow;
                                }
                              }
                              questions.add(Question(
                                  userChoices: chosedOption.value.toList(),
                                  syllogismType: syllogismType.value,
                                  majorPremise: majorPremise.value,
                                  minorPremise: minorPremise.value,
                                  userChoice: chosedOption.value.first,
                                  rightChoice: conclusion.value,
                                  premises: premises.value,
                                  isCorrect: answer.value,
                                  typeOfQuestion: typeOfQuestion.value,
                                  conclusions: conclusions.value,
                                  incorrectConclusions:
                                      incorrectConclusions.value,
                                  selectedCorrectOptions:
                                      selectedCorrectOptions.value,
                                  selectedIncorrectOptions:
                                      selectedIncorrectOptions.value,
                                  selectedOptionsInOrder:
                                      selectedOptionsInOrder.value));
                              randomOptions.clear();
                              nextQuestion();
                              setState(() {});
                            },
                            child: Text(
                              main_verifyTranslations[currentLanguageIndex],
                              maxLines: 1,
                              style: TextStyle(
                                fontSize:
                                    FontSizes(context).extraExtraExtraLarge,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                const Spacer(flex: 1),
              ],
            ),
          );
        }),
      );
    });
  }

  Map<String, dynamic> _randomQuestion() {
    final random = Random();

    // 1. Seleciona aleatoriamente um tema de silogismo ou dedução
    List<String> themesList = mapFileToContents.keys.toList();
    String theme = themesList[random.nextInt(themesList.length)];

    // 2. Seleciona aleatoriamente um tipo de silogismo ou dedução do tema selecionado
    Map<String, dynamic> syllogisms =
        Map<String, dynamic>.from(mapFileToContents[theme]);
    List<String> syllogismKeys = syllogisms.keys.toList();
    String selectedSyll = syllogismKeys[random.nextInt(syllogismKeys.length)];

    // Modus ponendo tollens de Medicina apresenta problemas
    if (selectedSyll == 'Modus ponendo tollens' && theme == 'Medicine') {
      return _randomQuestion();
    }
    syllogismType.value = selectedSyll;

    // 3. Seleciona aleatoriamente um silogismo do tipo selecionado
    List<dynamic> selectedSyllList = syllogisms[selectedSyll].values.toList();
    Map<String, dynamic> selectedSyllogism = Map<String, dynamic>.from(
        selectedSyllList[random.nextInt(selectedSyllList.length)]);

    // 4. Modifica o silogismo selecionado (remove elementos aleatórios de certas listas)
    if (!selectedSyllogism.containsKey('major premise')) {
      // Reduz o número de conclusões, se for uma lista
      if (selectedSyllogism['conclusion'] is List) {
        print('Conclusion is a list');
        List conclusions = selectedSyllogism['conclusion'];
        while (conclusions.length > 1) {
          conclusions.removeAt(random.nextInt(conclusions.length));
        }
      }

      // Remove parênteses das strings
      // Ecology Constructive Dilemma, ...
      for (String key in ['premises', 'conclusions', 'incorrect conclusions']) {
        if (selectedSyllogism.containsKey(key)) {
          List<dynamic> list = selectedSyllogism[key];
          for (int i = 0; i < list.length; i++) {
            if (list[i].contains('(A)') ||
                list[i].contains('(B)') ||
                list[i].contains('(C)') ||
                list[i].contains('(A or B)') ||
                list[i].contains('A or B') ||
                list[i].contains('A and B') ||
                list[i].contains('(A or C)') ||
                list[i].contains('(B or C)') ||
                list[i].contains('(A and B)') ||
                list[i].contains('(A and C)') ||
                list[i].contains('(B and C)')) {
              print(
                  "$theme $selectedSyll possui parênteses em $key, selecionando outro...");
              return _randomQuestion();
            }
            if (!(selectedSyll == 'Modus ponendo tollens' ||
                selectedSyll == 'Modus tollendo ponens')) {
              list[i] = list[i].replaceAll('(', '');
              list[i] = list[i].replaceAll(')', '');
            } else {
              list[i] = list[i].replaceAll('(', '"');
              list[i] = list[i].replaceAll(')', '"');
            }
          }
        }
      }
    }

    // Se alguma incorrect conclusions estiver em conclusions ou vice-versa, return _randomQuestion()
    // Biology Deduction 3, Astronomy Deduction 3, Computer Science Modus tollens, ...
    if (selectedSyllogism.containsKey('conclusions')) {
      List conclusions = selectedSyllogism['conclusions'];
      List incConclusions = selectedSyllogism['incorrect conclusions'];
      for (String incConclusion in incConclusions) {
        if (conclusions.contains(incConclusion)) {
          if (kDebugMode) {
            print(
                "$theme $selectedSyll possui conclusão incorreta em conclusões, selecionando outro...");
          }
          return _randomQuestion();
        }
      }
      for (String conclusion in conclusions) {
        if (incConclusions.contains(conclusion)) {
          if (kDebugMode) {
            print(
                "$theme $selectedSyll possui conclusão correta em incorrect conclusions, selecionando outro...");
          }
          return _randomQuestion();
        }
      }
    }

    // 5. Reduz o número de conclusões incorretas
    // if (selectedSyllogism['incorrect conclusions'].isNotEmpty) {
    //   List incConclusions = selectedSyllogism['incorrect conclusions'];
    //   while (incConclusions.length > 4) {
    //     incConclusions.removeAt(random.nextInt(incConclusions.length));
    //   }
    // }

    // 6. Define o tipo de questão
    if (selectedSyllogism.containsKey('premises')) {
      bool typeOfQuestionBool = Random().nextBool();
      typeOfQuestion.value = typeOfQuestionBool
          ? TypeOfQuestion.deductionTrue
          : TypeOfQuestion.deductionFalse;
    } else {
      typeOfQuestion.value = TypeOfQuestion.syllogism;
    }
    lastSyllTypeOfQuestion = typeOfQuestion.value;

    // 7. Retorna o silogismo modificado
    return selectedSyllogism;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 30),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            // button with text '-' that, when pressed, decrease _counter by 1
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _counter--;
                });
              },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
