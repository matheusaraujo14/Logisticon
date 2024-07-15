// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_test/main.dart';

class ShowQuestion extends StatefulWidget {
  const ShowQuestion({
    Key? key,
    required this.syllogism,
    required this.chosedOption,
    required this.answer,
  }) : super(key: key);
  final Map<String, dynamic> syllogism;
  final ValueNotifier<String> chosedOption;
  final ValueNotifier<AnswerQuestion> answer;

  @override
  ShowQuestionState createState() => ShowQuestionState();
}

const backgroundApp2 = Color.fromARGB(255, 255, 250, 232);
const backgroundApp = Color.fromARGB(255, 251, 238, 190);

class ShowQuestionState extends State<ShowQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Choose the correct conclusion for the following syllogism:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  // rounded corners for this container
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.syllogism.keys.first == 'major premise')...[
                      // text with size 16
                        Text("Major premise: " + widget.syllogism['major premise']!,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text("Minor premise: " + widget.syllogism['minor premise']!,
                            style: const TextStyle(fontSize: 16)),
                      ]else...[
                        // text with size 16
                        for (int i = 0; i < widget.syllogism['premises'].length; i++)...[
                          Text(widget.syllogism['premises'].elementAt(i)!,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                        ]
                      ]
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            _options(widget.syllogism, widget.chosedOption, widget.answer),
            // Text(syllogism['conclusion']!),
          ],
        ),
      ),
    );
  }

  Widget _options(
      Map<String, dynamic> syllogism,
      ValueNotifier<String> chosedOption,
      ValueNotifier<AnswerQuestion> answer) {
    var options = <String>[];
    String conclusion;
    if  (syllogism['conclusion'] is List) {
      conclusion = widget.syllogism['conclusion'][0]!;
    }else{
      conclusion = widget.syllogism['conclusion']!;
    }

    options.add(conclusion);
    /*
    syllogism has a key-value pair in the format
    	"incorrect conclusions": [
            "All animals are swans",
            "Some animals are not birds",
            "There are birds that are not animals",
            "Some swans are not animals"
			]
    Add to options all the incorrect conclusions
    */
    // List<dynamic>
    List<dynamic> incorrectConclusions =
        syllogism['incorrect conclusions']! as List<dynamic>;
    List<String> incorrectConclusionsList =
        List<String>.from(incorrectConclusions);
    /*  List<String> ls = [];
    for (var i = 0; i < incorrectConclusions.length; i++) {
      ls.add(incorrectConclusions[i] as String);
    }
    */
    options.addAll(incorrectConclusionsList);

    var randomOptions = options.toList()..shuffle();

    return ShowSyllogismOptions(
        randomOptions: randomOptions,
        chosenOption: chosedOption,
        answer: answer,
        conclusion: conclusion);
  }
}

class ShowSyllogismOptions extends StatefulWidget {
  const ShowSyllogismOptions({
    Key? key,
    required this.randomOptions,
    required this.chosenOption,
    required this.answer,
    required this.conclusion,
  }) : super(key: key);

  final List<String> randomOptions;
  final ValueNotifier<String> chosenOption;
  final ValueNotifier<AnswerQuestion> answer;
  final String conclusion;

  @override
  ShowSyllogismOptionsState createState() => ShowSyllogismOptionsState();
}

class ShowSyllogismOptionsState extends State<ShowSyllogismOptions> {
  ShowSyllogismOptionsState();

  @override
  Widget build(BuildContext context) {
    final int numberOfOptions = widget.randomOptions.length;

    var items = List<Column>.generate(
        numberOfOptions,
        (i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: double.infinity,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  color: widget.chosenOption.value == widget.randomOptions[i]
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // backgroundApp,
                  child: TextButton(
                    onPressed: () {
                      if (widget.chosenOption.value !=
                          widget.randomOptions[i]) {
                        widget.chosenOption.value = widget.randomOptions[i];
                        if (widget.randomOptions[i] == widget.conclusion) {
                          widget.answer.value = AnswerQuestion.correct;
                        } else {
                          widget.answer.value = AnswerQuestion.incorrect;
                        }
                      } else {
                        widget.chosenOption.value = 'none';
                        widget.answer.value = AnswerQuestion.notAnswered;
                      }
                      setState(() {});
                      // onChosenOption(chosenOption)
                    },
                    child: Text(
                      ' (${String.fromCharCode(i + 97)}) ${widget.randomOptions[i]}',
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        //   backgroundColor:
                        //       widget.chosenOption.value == widget.randomOptions[i]
                        //           ? Colors.green
                        //           : backgroundApp,
                        // ),
                      ),
                    ),
                  ),
                ),
                // put an horizontal line here using a widget
                if (i < numberOfOptions - 1)
                  const Divider(
                    height: 5,
                    thickness: 1,
                  ),
              ],
            ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syllogism question',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(198, 34, 0, 255),
        ),
        // seedColor: const Color.fromARGB(255, 64, 255, 179)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: ShowDismissibleContainer(
          width: 300,
          height: 120,
          fromTop: 20,
          fromLeft: 40,
          text:
              '''      The syllogism "Barbara" is valid because if all M are P and all S 
          are M, then all things that are S must also be P.
      
      This is because everything that is S falls within the 
      category of M, and since everything in M is also P, then everything 
      that is S must also be P.
      
      Think of it like Venn diagrams: If one circle (S) is entirely contained 
      within another circle (M), and that circle (M) is entirely contained 
      within a third circle (P), then everything in the first circle (S) must
       also be in the third circle (P).
      
      In short, the validity of "Barbara" lies in the logical relationship 
      between the categories: everything that falls within a smaller category 
      must also fall within the larger category.
      ''',
        ),
      ),
    );
  }
}

/// This widget, named ShowDismissibleContainer, shows a yellow container of
/// size cwidth x cheight positioned at fromTop from the top and fromLeft from the left of the screen.
/// cwidth and cheight are the width and height of the container, passed as parameters to the
/// widget constructor (ShowDismissibleContainer). fromTop and fromLeft are also passed as parameters.
/// When the user press outside the container, the container is dismissed.

class ShowDismissibleContainer extends StatefulWidget {
  const ShowDismissibleContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.fromTop,
    required this.fromLeft,
    required this.text, // Add this line
  }) : super(key: key);

  final double width;
  final double height;
  final double fromTop;
  final double fromLeft;
  final String text;
  @override
  State<ShowDismissibleContainer> createState() =>
      _ShowDismissibleContainerState();
}

class _ShowDismissibleContainerState extends State<ShowDismissibleContainer> {
  // Add this line
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var mytext = removeMultiple(widget.text);
    return Stack(
      children: [
        Positioned(
          top: widget.fromTop,
          left: widget.fromLeft,
          child: Container(
            width: widget.width,
            height: widget.height,

            /// a neomorphic container. Use the default colors of
            /// the theme for the background and the shadow
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(2, 2), // changes position of shadow
                ),
              ],
            ),

            //margin: const EdgeInsets.fromLTRB(8, 8, 10, 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 20),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                // Add this line
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 2, 40),
                  child: Text(mytext),
                ), // Add this line
              ),
            ), // Add this line
          ),
        ),
      ],
    );
  }
}


String removeMultiple(String input) {
  // replace \r\n by \n in input, put the result in input
  input = input.replaceAll('\r\n', '\n');
  var lines = input.split('\n');
  var output = '';
  bool lastWasNewLine = false;
  for (int i = 0; i < lines.length; ++i) {
    lines[i] = lines[i].trim();
    if (lines[i].isEmpty) {
      if (!lastWasNewLine) {
        output += '\n\n';
        lastWasNewLine = true;
      }
    } else {
      output += '${lines[i]} ';
      lastWasNewLine = false;
    }
  }
  return output;
}
