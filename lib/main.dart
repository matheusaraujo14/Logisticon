import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_test/animated_card.dart';
import 'package:new_test/color_test.dart';
import 'package:new_test/data.dart';
import 'package:new_test/riverpod_example.dart';
import 'package:new_test/show_questions.dart';
import 'package:new_test/start_page.dart';
import 'package:new_test/timer.dart';

late Map<String,dynamic> mapFileToContents;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Future<Map<String,dynamic>> tempLib = readJson();
  mapFileToContents = await tempLib;

  // mainRiverpod();
  runApp(const StartPage());

  // runApp(const TestApp());

  //runApp(const PopUpMenuTest());

  //runApp(const LogicalApp());

  //runApp(const MyAppColorTest());
  //runApp(const AnimatedTest());

  //showExampleBook();
}



Future<Map<String, dynamic>> readJson() async {
  final dir = Directory('assets/2024-05-19-Mai-24 - selecionados/');
  final dir2 = Directory('assets/deductions/');
  final List<FileSystemEntity> entities = await dir.list().toList();
  final List<FileSystemEntity> entitiesDeduc = await dir2.list().toList();
  dynamic data;
  String response;
  for (var i = 0; i < entities.length; i++){
    response = await rootBundle.loadString(entities[i].path);
    data ??= await json.decode(response);
    //print(entities[i].path);
    data.addAll(await json.decode(response));
  }
  for (var i = 0; i < entitiesDeduc.length; i++){
    response = await rootBundle.loadString(entitiesDeduc[i].path);
    data ??= await json.decode(response);
    //print(entitiesDeduc[i].path);
    data.addAll(await json.decode(response));
  }
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
        // seedColor: const Color.fromARGB(255, 64, 255, 179)),
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Syllogisms'),
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

  var answer = ValueNotifier<AnswerQuestion>(AnswerQuestion.notAnswered);
  double percentCorrectAnswers = 0;
  int numberOfCorrectAnswers = 0;
  int numberOfQuestions = 0;

  @override
  Widget build(BuildContext context) {
    // chosedOption.addListener(() {
    //   setState(() {});
    // });

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: Column(
        key: ValueKey<int>(numberOfQuestions),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowQuestion(
            syllogism: _randomQuestion(),
            chosedOption: chosedOption,
            answer: answer,
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Text Button that, on pressed, call setState
                  // and change the syllogism
                  TextButton(
                    onPressed: () {
                      Widget msg;
                      if (answer.value == AnswerQuestion.correct) {
                        msg = const Text('Correct answer');
                      } else if (answer.value == AnswerQuestion.incorrect) {
                        msg = const Text('Incorrect answer',
                            style: TextStyle(color: Colors.red));
                      } else {
                        msg = const Text('Not answered');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: msg,
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                      if (answer.value == AnswerQuestion.correct) {
                        ++numberOfCorrectAnswers;
                      }
                      ++numberOfQuestions;
                      percentCorrectAnswers =
                          numberOfCorrectAnswers / numberOfQuestions;
                      chosedOption.value = 'none';
                      answer.value = AnswerQuestion.notAnswered;

                      setState(() {});
                    },
                    child: const Text(
                      'Verify',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$numberOfCorrectAnswers/$numberOfQuestions',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  // a Text widget with the percentage of correct answers
                  // shown with two decimals
                  if (numberOfQuestions > 0)
                    Text(
                      '${(100 * percentCorrectAnswers).truncate()}% correct',
                      style: const TextStyle(fontSize: 12),
                    ),
                  const SizedBox(width: 20),
                  const TimerText(),
                ],
              ),
              IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
            // put an icon with 'home' that returns to the home page, poping
            // to the previous route
          ),
        ],
      ),
    );
  }


  Map<String, dynamic> _randomQuestion() {
    final random = Random();
    final max = random.nextInt(mapFileToContents.length);
    final value = mapFileToContents.values.elementAt(max);
    //var dataFromJson = jsonDecode(value);
    // get first key from dataFromJson
    var barbara = value[value.keys.first];
    //List<dynamic> barbara = data[data.keys.first];
    var barbaraSyllogism = barbara[random.nextInt(barbara.length)];

    if (barbaraSyllogism.keys.first == 'major premise'){
      for (var i = barbaraSyllogism.values.elementAt(3).length; i > 4; i--){
        barbaraSyllogism.values.elementAt(3).removeAt(random.nextInt(barbaraSyllogism.values.elementAt(3).length));
      }
      if (barbaraSyllogism.values.elementAt(2) is List){
        for (var i = barbaraSyllogism.values.elementAt(2).length; i > 1; i--){
          barbaraSyllogism.values.elementAt(2).removeAt(random.nextInt(barbaraSyllogism.values.elementAt(2).length));
        }
      }
    }else{
      for (var i = barbaraSyllogism.values.elementAt(2).length; i > 4; i--){
        barbaraSyllogism.values.elementAt(2).removeAt(random.nextInt(barbaraSyllogism.values.elementAt(2).length));
      }
      if (barbaraSyllogism.values.elementAt(1) is List){
        //print(barbaraSyllogism.keys.elementAt(1));

        var newMap = {
          for (var e in barbaraSyllogism.entries)
            if (e.key != 'conclusions')
              e.key: e.value
            else
              "conclusion" : e.value
        };
        barbaraSyllogism = Map<String, dynamic>.from(newMap);

        for (var i = barbaraSyllogism.values.elementAt(1).length; i > 1; i--){
          barbaraSyllogism.values.elementAt(1).removeAt(random.nextInt(barbaraSyllogism.values.elementAt(1).length));
        }
      }
    }

    //print(barbaraSyllogism);
    Map<String, dynamic> barbaraSyllogismMap =
        Map<String, dynamic>.from(barbaraSyllogism);
    return barbaraSyllogismMap;
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
