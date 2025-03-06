import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_test/main.dart';
import 'package:new_test/font_size.dart';
import 'package:new_test/show_explanation.dart';
import 'package:new_test/truth_table/truth_table.dart';
import 'global_language.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum TypeOfQuestion { syllogism, deductionTrue, deductionFalse }

class ShowQuestion extends StatefulWidget {
  ShowQuestion(
      {super.key,
      required this.syllogism,
      required this.chosedOption,
      required this.answer,
      required this.syllogismType,
      required this.majorPremise,
      required this.minorPremise,
      required this.conclusion,
      required this.premises,
      required this.conclusions,
      required this.typeOfQuestion,
      required this.incorrectConclusions,
      required this.selectedCorrectOptions,
      required this.selectedIncorrectOptions,
      required this.selectedOptionsInOrder});
  Map<String, dynamic> syllogism;
  final ValueNotifier<List<String>> chosedOption;
  final ValueNotifier<AnswerQuestion> answer;
  final ValueNotifier<String> syllogismType;
  final ValueNotifier<String> majorPremise;
  final ValueNotifier<String> minorPremise;
  final ValueNotifier<String> conclusion;
  final ValueNotifier<List<dynamic>> premises;
  final ValueNotifier<List<String>> conclusions;
  final ValueNotifier<List<String>> incorrectConclusions;
  final ValueNotifier<TypeOfQuestion> typeOfQuestion;
  final ValueNotifier<List<int>> selectedCorrectOptions;
  final ValueNotifier<List<int>> selectedIncorrectOptions;
  final ValueNotifier<List<int>> selectedOptionsInOrder;

  @override
  ShowQuestionState createState() => ShowQuestionState();
}

const backgroundApp2 = Color.fromARGB(255, 255, 250, 232);
const backgroundApp = Color.fromARGB(255, 251, 238, 190);

class ShowQuestionState extends State<ShowQuestion> {
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    if (!(widget.syllogism.containsKey('incorrect conclusions'))) {
      widget.syllogism = lastSyllogism!;
    }
    if (widget.syllogismType.value == 'none') {
      widget.syllogismType.value = lastSyllType;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedCorrectOptions.value = [];
    widget.selectedIncorrectOptions.value = [];
    widget.selectedOptionsInOrder.value = [];

    if (options == null || options.isEmpty) {
      options = getOptions(
          widget.syllogism,
          widget.chosedOption,
          widget.answer,
          widget.syllogismType,
          widget.majorPremise,
          widget.minorPremise,
          widget.premises,
          widget.conclusions,
          widget.conclusion,
          widget.typeOfQuestion,
          widget.incorrectConclusions,
          FontSizes(context));
    }

    if (widget.typeOfQuestion.value != TypeOfQuestion.syllogism &&
        widget.selectedCorrectOptions.value.isEmpty) {
      for (int i = 0; i < options.length; i++) {
        int index = widget.syllogism['conclusions'].indexOf(options[i]);
        if (index != -1) {
          widget.selectedCorrectOptions.value.add(index);
          widget.selectedOptionsInOrder.value.add(index);
        } else {
          index = widget.syllogism['incorrect conclusions'].indexOf(options[i]);
          if (index != -1) {
            int offset = widget.syllogism['conclusions'].length;
            widget.selectedIncorrectOptions.value.add(index + offset);
            widget.selectedOptionsInOrder.value.add(index + offset);
          }
        }
      }
    } else if (widget.typeOfQuestion.value == TypeOfQuestion.syllogism) {
      widget.selectedCorrectOptions.value = [];
      widget.selectedIncorrectOptions.value = [];
      widget.selectedOptionsInOrder.value = [];
    }

    FontSizes fontSizes = FontSizes(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calcular margens dinamicamente
    double horizontalMargin = screenWidth * 0.05;
    double topMargin = screenHeight * 0.07;
    double bottomMargin = screenHeight * 0.05;
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      int currentLanguageIndex = languageProvider.currentLanguageIndex;
      final ScrollController controller1 = ScrollController();
      final ScrollController controller2 = ScrollController();
      return Container(
        margin: EdgeInsets.fromLTRB(
            horizontalMargin,
            screenWidth > screenHeight ? topMargin : horizontalMargin + 10,
            horizontalMargin,
            bottomMargin),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: SelectableText(
                    maxLines: screenWidth > screenHeight ? 1 : 2,
                    minLines: 1,
                    textAlign: TextAlign.center,
                    widget.typeOfQuestion.value == TypeOfQuestion.syllogism
                        ? show_question_chooseCorrectConclusionTranslations[
                            currentLanguageIndex]
                        : widget.typeOfQuestion.value ==
                                TypeOfQuestion.deductionTrue
                            ? show_question_chooseCorrectConclusionDeductionTranslations[
                                currentLanguageIndex]
                            : show_question_chooseIncorrectConclusionDeductionTranslations[
                                currentLanguageIndex],
                    style: TextStyle(
                        fontSize: screenWidth > screenHeight
                            ? fontSizes.large
                            : fontSizes.small,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                // Conteúdo fixo (premissas)
                Theme(
                  data: ThemeData(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all<Color>(
                          Color.fromARGB(185, 115, 173, 149)),
                    ),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: controller1,
                    interactive: true,
                    child: Container(
                      height: screenWidth > screenHeight
                          ? constraints.maxHeight * 0.35
                          : constraints.maxHeight * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 110),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Theme(
                        data: ThemeData(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbColor: WidgetStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: controller1,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.syllogism.keys.first ==
                                  'major premise') ...[
                                SelectableText(
                                  "${show_question_majorPremiseTranslations[currentLanguageIndex]} ${widget.syllogism['major premise']!}",
                                  style: TextStyle(
                                    fontSize: screenWidth < screenHeight
                                        ? fontSizes.small
                                        : fontSizes.large - 2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                SelectableText(
                                  "${show_question_minorPremiseTranslations[currentLanguageIndex]} ${widget.syllogism['minor premise']!}",
                                  style: TextStyle(
                                    fontSize: screenWidth < screenHeight
                                        ? fontSizes.small
                                        : fontSizes.large - 2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ] else ...[
                                for (int i = 0;
                                    i < widget.syllogism['premises'].length;
                                    i++) ...[
                                  SelectableText(
                                    '• ${widget.syllogism['premises'].elementAt(i)!}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth < screenHeight
                                          ? fontSizes.small
                                          : fontSizes.medium,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ]
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: controller2,
                    interactive: true,
                    child: SingleChildScrollView(
                        controller: controller2,
                        child: ShowSyllogismOptions(
                            randomOptions: options,
                            chosenOption: widget.chosedOption,
                            answer: widget.answer,
                            majorPremise: widget.majorPremise,
                            minorPremise: widget.minorPremise,
                            conclusion: widget.conclusion.value,
                            premises: widget.premises,
                            typeOfQuestion: widget.typeOfQuestion.value,
                            conclusions: widget.conclusions.value,
                            incorrectConclusions:
                                widget.incorrectConclusions.value,
                            fontSizes: fontSizes)),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }

  List<String> getOptions(
      Map<String, dynamic> syllogism,
      ValueNotifier<List<String>> chosedOption,
      ValueNotifier<AnswerQuestion> answer,
      ValueNotifier<String> syllogismType,
      ValueNotifier<String> majorPremise,
      ValueNotifier<String> minorPremise,
      ValueNotifier<List<dynamic>> premises,
      ValueNotifier<List<String>> conclusions,
      ValueNotifier<String> conclusion,
      ValueNotifier<TypeOfQuestion> typeOfQuestion,
      ValueNotifier<List<String>> incorrectOptions,
      FontSizes fontSizes) {
    var syllOptions = <String>[];
    var deducOptions = <String>[];

    incorrectOptions.value = (syllogism['incorrect conclusions'] as List)
        .map((item) => item.toString())
        .toList();

    if (typeOfQuestion.value != TypeOfQuestion.syllogism &&
        syllogism.containsKey('conclusions')) {
      conclusions.value = (syllogism['conclusions'] as List)
          .map((item) => item.toString())
          .toList();
    } else {
      conclusion.value = syllogism['conclusion'] ?? ' ';
    }

    if (!syllogism.containsKey('major premise')) {
      if (conclusions.value.length + incorrectOptions.value.length > 5) {
        var randomConclusions = 0, randomIncorrect = 0;
        while (randomConclusions + randomIncorrect != 5) {
          randomConclusions = Random().nextInt(conclusions.value.length) + 1;
          randomIncorrect = Random().nextInt(incorrectOptions.value.length) + 1;
        }

        List<String> tempConclusions = List.from(conclusions.value);
        List<String> tempIncorrect = List.from(incorrectOptions.value);
        conclusions.value.clear();
        incorrectOptions.value.clear();
        for (int i = 0; i < randomConclusions; i++) {
          int index = Random().nextInt(tempConclusions.length);
          if (conclusions.value.contains(tempConclusions[index])) {
            i--;
            if (kDebugMode) {
              print("repeated: ${tempConclusions[index]} $index");
            }
            tempConclusions.removeAt(index);
            continue;
          }
          conclusions.value.add(tempConclusions[index]);
          tempConclusions.removeAt(index);
        }
        for (int i = 0; i < randomIncorrect; i++) {
          int index = Random().nextInt(tempIncorrect.length);
          if (incorrectOptions.value.contains(tempIncorrect[index])) {
            i--;
            if (kDebugMode) {
              print("repeated: ${tempIncorrect[index]} $index");
            }
            tempIncorrect.removeAt(index);
            continue;
          }
          incorrectOptions.value.add(tempIncorrect[index]);
          tempIncorrect.removeAt(index);
        }
      }
      deducOptions.addAll(conclusions.value);
      deducOptions.addAll(incorrectOptions.value);
    } else {
      syllOptions.add(conclusion.value);
      var randomOptions = 0;
      while (syllOptions.length != 5) {
        randomOptions = Random().nextInt(incorrectOptions.value.length);
        if (!syllOptions.contains(incorrectOptions.value[randomOptions])) {
          syllOptions.add(incorrectOptions.value[randomOptions]);
        }
      }
    }
    lastSyllType = syllogismType.value;
    lastSyllogism = syllogism;

    widget.incorrectConclusions.value = incorrectOptions.value;
    widget.conclusions.value = conclusions.value;

    if (widget.syllogism['premises'] != null) {
      majorPremise.value = 'none';
      minorPremise.value = 'none';
      premises.value = widget.syllogism['premises'];
    } else {
      majorPremise.value = widget.syllogism['major premise'];
      minorPremise.value = widget.syllogism['minor premise'];
      premises.value = [];
    }

    var syllRandomOptions = syllOptions.toList()..shuffle();
    var deducRandomOptions = deducOptions.toList()..shuffle();
    var options = deducRandomOptions;
    if (typeOfQuestion.value == TypeOfQuestion.syllogism) {
      options = syllRandomOptions;
    }

    if (typeOfQuestion.value != TypeOfQuestion.syllogism) {
      List<String> tempIncorrect = List.from(incorrectOptions.value);
      List<String> tempOptions = List.from(options);
      incorrectOptions.value.clear();
      conclusions.value.clear();
      for (int i = 0; i < tempOptions.length; i++) {
        if (tempIncorrect.contains(tempOptions[i])) {
          incorrectOptions.value.add(tempOptions[i]);
        } else {
          conclusions.value.add(tempOptions[i]);
        }
      }
      widget.incorrectConclusions.value = incorrectOptions.value;
      widget.conclusions.value = conclusions.value;
    }

    return options;
  }
}

class ShowSyllogismOptions extends StatefulWidget {
  const ShowSyllogismOptions({
    super.key,
    required this.randomOptions,
    required this.chosenOption,
    required this.answer,
    required this.majorPremise,
    required this.minorPremise,
    required this.conclusion,
    required this.premises,
    required this.typeOfQuestion,
    required this.conclusions,
    required this.incorrectConclusions,
    required this.fontSizes,
  });

  final List<String> randomOptions;
  final ValueNotifier<List<String>> chosenOption;
  final ValueNotifier<AnswerQuestion> answer;
  final ValueNotifier<String> majorPremise;
  final ValueNotifier<String> minorPremise;
  final ValueNotifier<List<dynamic>> premises;
  final TypeOfQuestion typeOfQuestion;
  final String conclusion;
  final List<String> conclusions;
  final List<String> incorrectConclusions;
  final FontSizes fontSizes;

  @override
  ShowSyllogismOptionsState createState() => ShowSyllogismOptionsState();
}

class ShowSyllogismOptionsState extends State<ShowSyllogismOptions> {
  ShowSyllogismOptionsState();

  // @override
  // void initState() {
  //   super.initState();
  //   generateOptions(); // Gera as opções apenas uma vez na inicialização
  // }

  // Função que gera as opções e armazena em uma lista de widgets
  void generateOptions(List<String> randomOptions, TypeOfQuestion type) {
    options = List<Widget>.generate(
      5,
      (i) => buildOption(i, randomOptions, type),
    );
  }

  AnswerQuestion allElementsInList(List<String> list1, List<String> list2) {
    if (list1.contains('') || list2.contains('')) {
      return AnswerQuestion.notAnswered;
    }
    for (int i = 0; i < list2.length; i++) {
      if (!list1.contains(list2[i])) {
        return AnswerQuestion.incorrect;
      }
    }
    for (int i = 0; i < list1.length; i++) {
      if (!list2.contains(list1[i])) {
        return AnswerQuestion.incorrect;
      }
    }
    return AnswerQuestion.correct;
  }

  List<int> getIndexes(List<String> list, List<String> subList) {
    List<int> indexes = [];
    for (int i = 0; i < list.length; i++) {
      if (subList.contains(list[i])) {
        indexes.add(i);
      }
    }
    return indexes;
  }

  int calculateTextLines(String text, double maxWidth, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length;
  }

  Widget buildOption(int i, List<String> randomOptions, TypeOfQuestion type) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenSizeH =
        screenHeight > screenWidth ? screenWidth : screenHeight;

    void selectOption() {
      if (type != TypeOfQuestion.syllogism) {
        if (!widget.chosenOption.value.contains(randomOptions[i])) {
          if (widget.chosenOption.value.contains('')) {
            widget.chosenOption.value.remove('');
          }
          widget.chosenOption.value.add(randomOptions[i]);
        } else {
          widget.chosenOption.value.remove(randomOptions[i]);
          if (widget.chosenOption.value.isEmpty) {
            widget.chosenOption.value.add('');
          }
        }
        if (type == TypeOfQuestion.deductionTrue) {
          widget.answer.value =
              allElementsInList(widget.chosenOption.value, widget.conclusions);
        } else {
          widget.answer.value = allElementsInList(
              widget.chosenOption.value, widget.incorrectConclusions);
        }
      } else {
        if (widget.chosenOption.value.first != randomOptions[i]) {
          widget.chosenOption.value.first = randomOptions[i];
          if (randomOptions[i] == widget.conclusion) {
            widget.answer.value = AnswerQuestion.correct;
          } else {
            widget.answer.value = AnswerQuestion.incorrect;
          }
        } else {
          widget.chosenOption.value.remove(randomOptions[i]);
          if (widget.chosenOption.value.isEmpty) {
            widget.chosenOption.value.add('');
          }
          widget.answer.value = AnswerQuestion.notAnswered;
        }
      }

      setState(() {});
    }

    Widget option = AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: i == 0
            ? BorderRadius.vertical(top: Radius.circular(20))
            : i == 4
                ? BorderRadius.vertical(bottom: Radius.circular(20))
                : BorderRadius.zero,
        color: widget.chosenOption.value.contains(randomOptions[i])
            ? Color.fromARGB(255, 240, 255, 253)
            : Theme.of(context).colorScheme.tertiaryContainer,
      ),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          selectOption();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: i == 0
                ? BorderRadius.vertical(top: Radius.circular(20))
                : i == 4
                    ? BorderRadius.vertical(bottom: Radius.circular(20))
                    : BorderRadius.zero,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 60,
          ),
          child: Container(
            height: screenWidth > screenHeight + 50
                ? screenSizeH *
                    (0.07 +
                        0.03 *
                            (calculateTextLines(
                                    randomOptions[i],
                                    screenWidth * 0.8,
                                    TextStyle(
                                        fontSize:
                                            widget.fontSizes.extraSmall)) -
                                1))
                : null,
            padding: EdgeInsets.symmetric(horizontal: screenSizeH * 0.02),
            child: Stack(
              alignment: Alignment.center, // Centraliza o texto
              children: [
                Align(
                  alignment: Alignment
                      .centerLeft, // Alinha o ícone ou letra à esquerda
                  child: type == TypeOfQuestion.syllogism
                      ? Text(
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          '${String.fromCharCode(i + 97)})',
                          style: TextStyle(
                            fontSize: widget.fontSizes.extraSmall,
                            fontWeight: FontWeight.bold,
                            color: widget.chosenOption.value
                                    .contains(randomOptions[i])
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : Icon(
                          type == TypeOfQuestion.deductionTrue
                              ? widget.chosenOption.value
                                      .contains(randomOptions[i])
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked
                              : widget.chosenOption.value
                                      .contains(randomOptions[i])
                                  ? Icons.cancel
                                  : Icons.radio_button_unchecked,
                          color: widget.chosenOption.value
                                  .contains(randomOptions[i])
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          size: screenWidth > screenHeight
                              ? widget.fontSizes.extraSmall
                              : widget.fontSizes.medium,
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  padding: const EdgeInsets.only(right: 30),
                  child: Center(
                    widthFactor: screenWidth,
                    // Centraliza o texto
                    child: SelectableText(
                      onTap: () {
                        selectOption();
                      },
                      textAlign: TextAlign.center,
                      randomOptions[i],
                      style: TextStyle(
                        fontSize: widget.fontSizes.extraSmall,
                        color:
                            widget.chosenOption.value.contains(randomOptions[i])
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return option;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.randomOptions.isNotEmpty) {
      randomOptions = widget.randomOptions;
      type = widget.typeOfQuestion;
    }
    generateOptions(randomOptions, type);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options,
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
    super.key,
    required this.width,
    required this.height,
    required this.fromTop,
    required this.fromLeft,
    required this.text, // Add this line
  });

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
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                interactive: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(6, 8, 6, 20),
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  // Add this line
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(2, 8, 2, 40),
                    child: SelectableText(mytext),
                  ), // Add this line
                ),
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
