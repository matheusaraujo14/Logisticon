// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:new_test/main.dart';

class ShowQuestion extends StatefulWidget {
  const ShowQuestion({
    Key? key,
    required this.syllogism,
    required this.chosedOption,
    required this.answer,
    required this.syllogismType,
    required this.majorPremise,
    required this.minorPremise,
    required this.conclusion,
    required this.premises,
  }) : super(key: key);
  final Map<String, dynamic> syllogism;
  final ValueNotifier<String> chosedOption;
  final ValueNotifier<AnswerQuestion> answer;
  final ValueNotifier<String> syllogismType;
  final ValueNotifier<String> majorPremise;
  final ValueNotifier<String> minorPremise;
  final ValueNotifier<String> conclusion;
  final ValueNotifier<List<dynamic>> premises;

  @override
  ShowQuestionState createState() => ShowQuestionState();
}

const backgroundApp2 = Color.fromARGB(255, 255, 250, 232);
const backgroundApp = Color.fromARGB(255, 251, 238, 190);

class ShowQuestionState extends State<ShowQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 125, 100, 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                'Choose the correct conclusion for the following syllogism (${widget.syllogismType.value}):',
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  // rounded corners for this container
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.syllogism.keys.first == 'major premise') ...[
                        Text(
                            "Major premise: " +
                                widget.syllogism['major premise']!,
                            style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 10),
                        Text(
                            "Minor premise: " +
                                widget.syllogism['minor premise']!,
                            style: const TextStyle(fontSize: 32)),
                      ] else ...[
                        // text with size 16
                        for (int i = 0;
                            i < widget.syllogism['premises'].length;
                            i++) ...[
                          Text(widget.syllogism['premises'].elementAt(i)!,
                              style: const TextStyle(fontSize: 28)),
                          const SizedBox(height: 10),
                        ]
                      ]
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            _options(
                widget.syllogism,
                widget.chosedOption,
                widget.answer,
                widget.syllogismType,
                widget.majorPremise,
                widget.minorPremise,
                widget.conclusion,
                widget.premises),
          ],
        ),
      ),
    );
  }

  Widget _options(
      Map<String, dynamic> syllogism,
      ValueNotifier<String> chosedOption,
      ValueNotifier<AnswerQuestion> answer,
      ValueNotifier<String> syllogismType,
      ValueNotifier<String> majorPremise,
      ValueNotifier<String> minorPremise,
      ValueNotifier<String> rightConclusion,
      ValueNotifier<List<dynamic>> premises) {
    var options = <String>[];
    String conclusion;
    if (syllogism.containsKey('conclusions')) {
      conclusion = widget.syllogism['conclusions'][0]!;
    } else {
      // print(widget.syllogism);
      conclusion = widget.syllogism['conclusion'];
    }

    options.add(conclusion);

    // List<dynamic>
    List<dynamic> incorrectConclusions =
        syllogism['incorrect conclusions']! as List<dynamic>;
    List<String> incorrectConclusionsList =
        List<String>.from(incorrectConclusions);

    options.addAll(incorrectConclusionsList);
    if (widget.syllogism['premises'] != null) {
      majorPremise.value = 'none';
      minorPremise.value = 'none';
      premises.value = widget.syllogism['premises'] ?? 'none';
    } else {
      majorPremise.value = widget.syllogism['major premise'] ?? 'none';
      minorPremise.value = widget.syllogism['minor premise'] ?? 'none';
      premises.value = [];
    }

    rightConclusion.value = conclusion;

    var randomOptions = options.toList()..shuffle();
    return ShowSyllogismOptions(
        randomOptions: randomOptions,
        chosenOption: chosedOption,
        answer: answer,
        majorPremise: majorPremise,
        minorPremise: minorPremise,
        conclusion: conclusion,
        premises: premises);
  }
}

class ShowSyllogismOptions extends StatefulWidget {
  const ShowSyllogismOptions({
    Key? key,
    required this.randomOptions,
    required this.chosenOption,
    required this.answer,
    required this.majorPremise,
    required this.minorPremise,
    required this.conclusion,
    required this.premises,
  }) : super(key: key);

  final List<String> randomOptions;
  final ValueNotifier<String> chosenOption;
  final ValueNotifier<AnswerQuestion> answer;
  final ValueNotifier<String> majorPremise;
  final ValueNotifier<String> minorPremise;
  final ValueNotifier<List<dynamic>> premises;
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: widget.chosenOption.value == widget.randomOptions[i]
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context)
                            .colorScheme
                            .tertiaryContainer, // backgroundApp,
                  ),
                  height: 70,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      widget.chosenOption.value == widget.randomOptions[i];
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${String.fromCharCode(i + 97)})',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            ' ${widget.randomOptions[i]}',
                            style: TextStyle(
                              fontSize: widget.randomOptions[i].length > 160
                                  ? 18
                                  : widget.randomOptions[i].length > 140
                                      ? 20
                                      : widget.randomOptions[i].length > 120
                                          ? 22
                                          : 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // put an space between the options
                if (i < numberOfOptions - 1)
                  const SizedBox(
                    height: 8,
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
