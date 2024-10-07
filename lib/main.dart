import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_test/data.dart';
import 'package:new_test/show_questions.dart';
import 'package:new_test/start_page.dart';
import 'package:new_test/show_history.dart';
import 'package:new_test/show_explanation.dart';
// import 'package:new_test/timer.dart';

late Map<String, dynamic> mapFileToContents;
final List<Question> questions = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<Map<String, dynamic>> tempLib = readJson();
  mapFileToContents = await tempLib;

  // mainRiverpod();
  runApp(const MaterialApp(home: StartPage()));

  // runApp(const TestApp());

  //runApp(const PopUpMenuTest());

  // runApp(const LogicalApp());

  //runApp(const MyAppColorTest());
  //runApp(const AnimatedTest());

  //showExampleBook();
}

Future<Map<String, dynamic>> readJson() async {
  final dir = Directory('assets/2024-05-19-Mai-24 - selecionados/');
  final dir2 = Directory('assets/deductions/');
  final List<FileSystemEntity> entities = await dir.list().toList();
  final List<FileSystemEntity> entitiesDeduc = await dir2.list().toList();
  dynamic data = {};
  String response = '', fileName = '', context = '';
  Map<String, dynamic> decodedData = {};
  List<String> fileNameList = [];
  List<String> contextList = [];

  String getFirstKey(Map<String, dynamic> file) {
    String first = file.keys.first;
    return first;
  }

  String getKeyFromFirstObject(Map<String, dynamic> file) {
    String object = file.keys.first;
    String firstKey = file[object].keys.first;
    return firstKey;
  }

  // data está no formato: {fileName: {context: {index: item}}}
  // decodedData está no formato: {context: {fileName: [item]}} para silogismos
  for (var i = 0; i < entities.length; i++) {
    response = await rootBundle.loadString(entities[i].path);
    decodedData = json.decode(response);
    fileName = getKeyFromFirstObject(decodedData);
    if (!data.containsKey(fileName)) data[fileName] = {};
    context = getFirstKey(decodedData);
    if (!data[fileName].containsKey(context)) data[fileName][context] = {};
    if (!fileNameList.contains(fileName)) fileNameList.add(fileName);
    if (!contextList.contains(context)) contextList.add(context);

    int j = 0;
    for (var item in decodedData[context][fileName]) {
      if (!data[fileName][context].containsKey(j)) {
        data[fileName][context][j] = {};
      }
      data[fileName][context][j] = item;
      j++;
    }
  }

  // data está no formato: {fileName: {context: {index: item}}}
  // decodedData está no formato: {fileName: {context: [item]}} para deduções
  for (var i = 0; i < entitiesDeduc.length; i++) {
    response = await rootBundle.loadString(entitiesDeduc[i].path);
    decodedData = json.decode(response);
    fileName = getFirstKey(decodedData);
    if (!data.containsKey(fileName)) data[fileName] = {};
    context = getKeyFromFirstObject(decodedData);
    if (!data[fileName].containsKey(context)) data[fileName][context] = {};
    if (!fileNameList.contains(fileName)) fileNameList.add(fileName);
    if (!contextList.contains(context)) contextList.add(context);

    int j = 0;
    for (var item in decodedData[fileName][context]) {
      if (!data[fileName][context].containsKey(j)) {
        data[fileName][context][j] = {};
      }
      data[fileName][context][j] = item;
      j++;
    }
  }

  data = Map<String, dynamic>.from(data);

  // imprima a lista de arquivos e contextos
  // print("Lista de arquivos de silogismos: $fileNameList");
  // print("Lista de contextos dos silogismos: $contextList");

  return data;
}

class LogicalApp extends StatelessWidget {
  const LogicalApp({super.key});

  // This widget is the root of your application.
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
      home: const MyLogicalApp(),
    );
  }
}

class MyLogicalApp extends StatefulWidget {
  const MyLogicalApp({super.key});

  @override
  State<MyLogicalApp> createState() => MyLogicalAppState();
}

class MyLogicalAppState extends State<MyLogicalApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text(
            'Syllogisms',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // adicionar botao para voltar para a home
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              questions.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartPage()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Back',
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 35,
          ),
        ),
        body: const ShowQuestionList(),
      ),
    );
  }
}

// create a ShowQuestionList statefull widget
class ShowQuestionList extends StatefulWidget {
  const ShowQuestionList({super.key});

  @override
  State<ShowQuestionList> createState() => ShowQuestionListState();
}

enum AnswerQuestion { correct, incorrect, notAnswered }

class ShowQuestionListState extends State<ShowQuestionList> {
  ValueNotifier<String> chosedOption = ValueNotifier<String>('none');
  ValueNotifier<List<String>> otherOptions = ValueNotifier<List<String>>(['']);
  ValueNotifier<String> syllogismType = ValueNotifier<String>('none');
  ValueNotifier<AnswerQuestion> answer =
      ValueNotifier<AnswerQuestion>(AnswerQuestion.notAnswered);
  ValueNotifier<String> majorPremise = ValueNotifier<String>('none');
  ValueNotifier<String> minorPremise = ValueNotifier<String>('none');
  ValueNotifier<String> conclusion = ValueNotifier<String>('none');
  ValueNotifier<List<dynamic>> premises =
      ValueNotifier<List<dynamic>>(['none']);
  //var answer = ValueNotifier<AnswerQuestion>(AnswerQuestion.notAnswered);
  double percentCorrectAnswers = 0;
  int numberOfCorrectAnswers = 0;
  int numberOfQuestions = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background5.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Column(
          key: ValueKey<int>(numberOfQuestions),
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShowQuestion(
              syllogism: _randomQuestion(),
              chosedOption: chosedOption,
              answer: answer,
              syllogismType: syllogismType,
              majorPremise: majorPremise,
              minorPremise: minorPremise,
              conclusion: conclusion,
              premises: premises,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                        ),
                        child: Row(
                          children: [
                            Text(
                              '$numberOfCorrectAnswers/$numberOfQuestions',
                              style: TextStyle(
                                fontSize: 32,
                                color: numberOfCorrectAnswers >=
                                            numberOfQuestions / 2 &&
                                        numberOfQuestions > 0
                                    ? Colors.green
                                    : numberOfQuestions == 0
                                        ? Colors.grey.shade700
                                        : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (numberOfQuestions > 0)
                              Text(
                                '${(100 * percentCorrectAnswers).truncate()}% Correct',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: numberOfCorrectAnswers >=
                                          numberOfQuestions / 2
                                      ? Colors.green
                                      : numberOfQuestions == 0
                                          ? Colors.grey.shade700
                                          : Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (numberOfQuestions == 0)
                              Text(
                                '-% Correct',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 300),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade200,
                          foregroundColor: Colors.brown.shade800,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 150, vertical: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 10,
                        ),
                        onPressed: () {
                          Widget msg;
                          if (answer.value == AnswerQuestion.correct) {
                            msg = const Text('Correct answer',
                                style: TextStyle(fontSize: 20));
                          } else if (answer.value == AnswerQuestion.incorrect) {
                            msg = const Text('Incorrect answer',
                                style: TextStyle(fontSize: 20));
                          } else {
                            msg = const Text('Not answered',
                                style: TextStyle(fontSize: 20));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: msg,
                                duration: const Duration(milliseconds: 800),
                                backgroundColor: answer.value ==
                                        AnswerQuestion.correct
                                    ? Colors.green
                                    : answer.value == AnswerQuestion.notAnswered
                                        ? Colors.grey
                                        : Colors.red),
                          );
                          if (answer.value == AnswerQuestion.correct) {
                            ++numberOfCorrectAnswers;
                          }
                          ++numberOfQuestions;
                          percentCorrectAnswers =
                              numberOfCorrectAnswers / numberOfQuestions;
                          questions.add(Question(
                            syllogismType: syllogismType.value,
                            majorPremise: majorPremise.value,
                            minorPremise: minorPremise.value,
                            rightChoice: conclusion.value,
                            userChoice: chosedOption.value,
                            premises: premises.value,
                            isCorrect: answer.value,
                          ));

                          answer.value = AnswerQuestion.notAnswered;
                          setState(() {});
                        },
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 40,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 300),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.lightBlue,
                                width: 5,
                              ),
                            ),
                            child: IconButton(
                              hoverColor: Colors.white,
                              iconSize: 100,
                              focusColor: Colors.lightBlue,
                              icon: const Icon(Icons.help,
                                  color: Colors.lightBlue),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey.shade200,
                                      title: const Text(
                                        'Do you want an explanation of this syllogism?',
                                        style: TextStyle(fontSize: 28),
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
                                              child: const Text('NO',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ),
                                            // Botão YES
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
                                                showExplanation(context,
                                                    syllogismType.value);
                                              },
                                              child: const Text('YES',
                                                  style:
                                                      TextStyle(fontSize: 20)),
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
                          const SizedBox(width: 54.5),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                              border: Border.all(
                                color: Colors.teal,
                                width: 5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: IconButton(
                              hoverColor: Colors.white,
                              alignment: Alignment.center,
                              icon:
                                  const Icon(Icons.history, color: Colors.teal),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey.shade200,
                                      title: const Text(
                                        'History',
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
                                          : const Text(
                                              'No questions answered yet.',
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
                                            child: const Text('OK',
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
                              iconSize: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _randomQuestion() {
    final random = Random();

    // 1. Seleciona aleatoriamente um tipo de silogismo do mapa
    List<String> tiposDeSilogismos = mapFileToContents.keys.toList();
    String silogismoTipo =
        tiposDeSilogismos[random.nextInt(tiposDeSilogismos.length)];

    // 2. Seleciona aleatoriamente um contexto associado ao tipo de silogismo
    Map<String, dynamic> contexts =
        Map<String, dynamic>.from(mapFileToContents[silogismoTipo]);
    List<String> contextKeys = contexts.keys.toList();
    String selectedContext = contextKeys[random.nextInt(contextKeys.length)];

    // 3. Verifica se o contexto selecionado tem silogismos
    if (contexts[selectedContext].isEmpty) {
      print(
          "Nenhum silogismo $silogismoTipo encontrado no contexto $selectedContext, selecionando outro...");
      return _randomQuestion(); // Chama a função novamente para tentar outro silogismo
    }

    syllogismType.value = silogismoTipo;

    // 4. Seleciona aleatoriamente um silogismo do contexto selecionado
    List<dynamic> silogismoList = contexts[selectedContext].values.toList();
    Map<String, dynamic> selectedSyllogism = Map<String, dynamic>.from(
        silogismoList[random.nextInt(silogismoList.length)]);

    // 5. Modifica o silogismo selecionado (remove elementos aleatórios de certas listas)
    if (!selectedSyllogism.containsKey('major premise')) {
      // Reduz o número de conclusões, se for uma lista
      if (selectedSyllogism['conclusion'] is List) {
        List conclusions = selectedSyllogism['conclusion'];
        while (conclusions.length > 1) {
          conclusions.removeAt(random.nextInt(conclusions.length));
        }
      }
    }
    // Alguns arquivos estão com keys com nome errado: Bocardo History,
    if (selectedSyllogism.containsKey('incorrect_conclusions')) {
      print(
          "$silogismoTipo $selectedContext possui campo com nome errado, selecionando outro...");
      return _randomQuestion();
    }
    // Reduz o número de conclusões incorretas
    print("$silogismoTipo $selectedContext");
    if (selectedSyllogism['incorrect conclusions'].isNotEmpty) {
      List incorrectConclusions = selectedSyllogism['incorrect conclusions'];
      while (incorrectConclusions.length > 4) {
        incorrectConclusions
            .removeAt(random.nextInt(incorrectConclusions.length));
      }
    }

    // 6. Retorna o silogismo modificado
    return selectedSyllogism;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
