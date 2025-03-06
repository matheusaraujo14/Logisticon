import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:new_test/font_size.dart';
import 'package:new_test/main.dart';
import 'package:new_test/show_explanation.dart';
import 'package:new_test/show_explanation_deduction.dart';
import 'package:new_test/show_questions.dart';
import 'package:provider/provider.dart';
import 'global_language.dart';

class Question {
  final AnswerQuestion isCorrect;
  final TypeOfQuestion typeOfQuestion;
  // syllogism variables
  final String majorPremise;
  final String minorPremise;
  final String rightChoice;
  final String userChoice;
  final String syllogismType;
  // deduction variables
  final List<dynamic> premises;
  final List<String> conclusions;
  final List<String> userChoices;
  final List<String> incorrectConclusions;
  final List<int> selectedCorrectOptions;
  final List<int> selectedIncorrectOptions;
  final List<int> selectedOptionsInOrder;

  Question(
      {required this.majorPremise,
      required this.minorPremise,
      required this.premises,
      required this.userChoice,
      required this.rightChoice,
      required this.syllogismType,
      required this.isCorrect,
      required this.typeOfQuestion,
      required this.conclusions,
      required this.userChoices,
      required this.incorrectConclusions,
      required this.selectedCorrectOptions,
      required this.selectedIncorrectOptions,
      required this.selectedOptionsInOrder});
}

class QuestionTile extends StatefulWidget {
  final Question question;

  const QuestionTile({Key? key, required this.question}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuestionTileState createState() => _QuestionTileState();
}

bool verifyError(
    String rightChoice,
    String userChoice,
    List<String> userChoices,
    List<String> incorrectConclusions,
    List<String> conclusions,
    TypeOfQuestion typeOfQuestion) {
  if (typeOfQuestion != TypeOfQuestion.syllogism && userChoices.isNotEmpty) {
    for (var opt in userChoices) {
      if (!conclusions.contains(opt) &&
          conclusions.isNotEmpty &&
          !incorrectConclusions.contains(opt) &&
          opt.isNotEmpty) {
        if (kDebugMode) {
          print(userChoice);
          print(conclusions);
          print(incorrectConclusions);
        }
        return true;
      }
    }
  } else if (userChoice.isNotEmpty) {
    if (rightChoice != userChoice &&
        !incorrectConclusions.contains(userChoice)) {
      if (kDebugMode) {
        print(userChoice);
        print(rightChoice);
        print(incorrectConclusions);
      }
      return true;
    }
  }
  return false;
}

class _QuestionTileState extends State<QuestionTile> {
  bool _isHovering = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool error = verifyError(
        widget.question.rightChoice,
        widget.question.userChoice,
        widget.question.userChoices,
        widget.question.incorrectConclusions,
        widget.question.conclusions,
        widget.question.typeOfQuestion);

    if (error) {
      return Container();
    }
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      int currentLanguageIndex = languageProvider.currentLanguageIndex;
      return MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: _isHovering
                    ? getBorderColor(widget.question.isCorrect)
                    : widget.question.isCorrect == AnswerQuestion.correct
                        ? Colors.green.shade400
                        : widget.question.isCorrect ==
                                AnswerQuestion.notAnswered
                            ? Colors.grey
                            : Colors.red.shade400,
                width: screenWidth > screenHeight
                    ? _isHovering
                        ? 2.5
                        : 2
                    : 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            leading: screenWidth > screenHeight
                ? Icon(
                    widget.question.isCorrect == AnswerQuestion.correct
                        ? Icons.check
                        : Icons.close,
                    color: widget.question.isCorrect == AnswerQuestion.correct
                        ? Colors.green
                        : widget.question.isCorrect ==
                                AnswerQuestion.notAnswered
                            ? Colors.grey.shade700
                            : Colors.red,
                  )
                : null,
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: screenWidth > screenHeight
                        ? FontSizes(context).extraSmall
                        : null),
                children: <InlineSpan>[
                  WidgetSpan(
                    child: HoverText(question: widget.question),
                  ),
                  const WidgetSpan(child: SizedBox(height: 5)),
                  if (screenWidth > screenHeight) ...[
                    const WidgetSpan(child: SizedBox(width: 10)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: IconButton(
                        tooltip: show_history_reportQuestionTranslations[
                            currentLanguageIndex],
                        iconSize: 26,
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
                                          currentLanguageIndex],
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
                                              show_history_closeTranslations[
                                                  currentLanguageIndex],
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
                                                        milliseconds: 2500),
                                                    () {
                                                  Navigator.of(context).pop();
                                                });
                                                return AlertDialog(
                                                  backgroundColor: Colors.red,
                                                  title: SelectableText(
                                                      show_history_thanksForYourReportTranslations[
                                                          currentLanguageIndex],
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
                                                  currentLanguageIndex],
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
                    ),
                  ]
                ],
              ),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (widget.question.premises.isNotEmpty) ...[
                SelectableText(
                  show_history_premisesTranslations[currentLanguageIndex],
                  style: TextStyle(
                    fontSize: screenWidth > screenHeight
                        ? FontSizes(context).extraExtraExtraSmall
                        : FontSizes(context).extraSmall,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                for (var premise in widget.question.premises) ...[
                  SelectableText(
                    '• $premise',
                    style: TextStyle(
                      fontSize: screenWidth > screenHeight
                          ? FontSizes(context).extraExtraExtraSmall
                          : FontSizes(context).extraSmall,
                      color: Colors.black,
                    ),
                  ),
                ],
              ] else ...[
                SelectableText.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: screenWidth > screenHeight
                          ? FontSizes(context).extraExtraExtraSmall
                          : FontSizes(context).extraSmall,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: show_history_majorPremiseTranslations[
                            currentLanguageIndex],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: widget.question.majorPremise,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: screenWidth > screenHeight
                          ? FontSizes(context).extraExtraExtraSmall
                          : FontSizes(context).extraSmall,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: show_history_minorPremiseTranslations[
                            currentLanguageIndex],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: widget.question.minorPremise,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
              SelectableText.rich(
                TextSpan(
                  style: TextStyle(
                      fontSize: screenWidth > screenHeight
                          ? FontSizes(context).extraExtraExtraSmall
                          : screenHeight * 0.025,
                      color: Colors.green),
                  children: [
                    if (widget.question.premises.isEmpty) ...[
                      TextSpan(
                        text: show_history_conclusionTranslations[
                            currentLanguageIndex],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth < screenHeight
                                ? FontSizes(context).extraSmall
                                : null),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: IconButton(
                          color: Colors.green,
                          icon: Icon(
                            _isExpanded
                                ? Icons.arrow_circle_left_outlined
                                : Icons.arrow_circle_right_outlined,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ),
                      if (_isExpanded) ...[
                        TextSpan(
                          text: widget.question.rightChoice,
                          style: TextStyle(
                            fontSize: screenWidth < screenHeight
                                ? FontSizes(context).extraSmall
                                : null,
                          ),
                        ),
                      ],
                    ] else ...[
                      if (widget.question.typeOfQuestion ==
                          TypeOfQuestion.deductionTrue) ...[
                        TextSpan(
                          text: show_history_conclusionTranslations[
                              currentLanguageIndex],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth < screenHeight
                                  ? FontSizes(context).extraSmall
                                  : null),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: IconButton(
                            icon: Icon(
                              color: Colors.green,
                              size: 24,
                              _isExpanded
                                  ? Icons.arrow_circle_up_outlined
                                  : Icons.arrow_circle_down_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                          ),
                        ),
                        if (_isExpanded) ...[
                          for (var conclusion
                              in widget.question.conclusions) ...[
                            TextSpan(
                              text: '\n• $conclusion',
                              style: screenWidth < screenHeight
                                  ? TextStyle(
                                      fontSize: FontSizes(context).extraSmall,
                                    )
                                  : null,
                            ),
                          ],
                        ]
                      ] else ...[
                        TextSpan(
                          text: show_history_incorrectConclusionTranslations[
                              currentLanguageIndex],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth < screenHeight
                                  ? FontSizes(context).extraSmall
                                  : null),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: IconButton(
                            icon: Icon(
                              color: Colors.green,
                              size: 24,
                              _isExpanded
                                  ? Icons.arrow_circle_up_outlined
                                  : Icons.arrow_circle_down_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                          ),
                        ),
                        if (_isExpanded) ...[
                          for (var conclusion
                              in widget.question.incorrectConclusions) ...[
                            TextSpan(
                              text: '\n• $conclusion',
                              style: screenWidth < screenHeight
                                  ? TextStyle(
                                      fontSize: FontSizes(context).extraSmall,
                                    )
                                  : null,
                            ),
                          ],
                        ]
                      ],
                    ],
                  ],
                ),
              ),
              SelectableText.rich(
                TextSpan(
                  style: TextStyle(
                      fontSize: screenWidth > screenHeight
                          ? FontSizes(context).extraExtraExtraSmall
                          : screenHeight * 0.023,
                      color: widget.question.isCorrect == AnswerQuestion.correct
                          ? Colors.green
                          : widget.question.isCorrect ==
                                  AnswerQuestion.notAnswered
                              ? Colors.grey.shade700
                              : Colors.red),
                  children: <TextSpan>[
                    TextSpan(
                      text: show_history_selectedTranslations[
                          currentLanguageIndex],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth < screenHeight
                              ? FontSizes(context).extraSmall
                              : null),
                    ),
                    if (widget.question.isCorrect ==
                        AnswerQuestion.notAnswered) ...[
                      TextSpan(
                          style: TextStyle(
                            fontSize: screenWidth < screenHeight
                                ? FontSizes(context).extraSmall
                                : null,
                          ),
                          text: show_history_notAnsweredTranslations[
                              currentLanguageIndex]),
                    ] else if (widget.question.premises.isEmpty) ...[
                      TextSpan(
                          text: widget.question.userChoice,
                          style: TextStyle(
                            fontSize: screenWidth < screenHeight
                                ? FontSizes(context).extraSmall
                                : null,
                          )),
                    ] else ...[
                      for (var q in widget.question.userChoices) ...[
                        if (widget.question.typeOfQuestion ==
                            TypeOfQuestion.deductionTrue) ...[
                          TextSpan(
                            text: widget.question.conclusions.contains(q)
                                ? '\n✓ $q'
                                : '\n✕ $q',
                            style: TextStyle(
                                fontSize: screenWidth < screenHeight
                                    ? FontSizes(context).extraSmall
                                    : null,
                                color:
                                    widget.question.conclusions.contains(q) &&
                                            widget.question.isCorrect ==
                                                AnswerQuestion.incorrect
                                        ? Colors.orange
                                        : widget.question.isCorrect ==
                                                AnswerQuestion.incorrect
                                            ? Colors.red
                                            : Colors.green),
                          ),
                        ] else ...[
                          TextSpan(
                            text:
                                widget.question.incorrectConclusions.contains(q)
                                    ? '\n✓ $q'
                                    : '\n✕ $q',
                            style: TextStyle(
                                fontSize: screenWidth < screenHeight
                                    ? FontSizes(context).extraSmall
                                    : null,
                                color: widget.question.incorrectConclusions
                                            .contains(q) &&
                                        widget.question.isCorrect ==
                                            AnswerQuestion.incorrect
                                    ? Colors.orange
                                    : widget.question.isCorrect ==
                                            AnswerQuestion.incorrect
                                        ? Colors.red
                                        : Colors.green),
                          ),
                        ]
                      ],
                    ]
                  ],
                ),
              ),
              if (screenWidth < screenHeight) ...[
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RainbowButton(
                        onPressed: () {
                          if (widget.question.typeOfQuestion ==
                              TypeOfQuestion.syllogism) {
                            showExplanation(
                              context,
                              widget.question.syllogismType,
                              widget.question.premises.isEmpty ? true : false,
                              widget.question.selectedCorrectOptions,
                              widget.question.selectedIncorrectOptions,
                            );
                          } else {
                            showTestDeduction(context,
                                premises:
                                    ValueNotifier(widget.question.premises),
                                conclusions:
                                    ValueNotifier(widget.question.conclusions),
                                incorrectConclusions: ValueNotifier(
                                    widget.question.incorrectConclusions),
                                selectedCorrectOptions: ValueNotifier(
                                    widget.question.selectedCorrectOptions),
                                selectedIncorrectOptions: ValueNotifier(
                                    widget.question.selectedIncorrectOptions),
                                sylogismType: widget.question.syllogismType,
                                selectedOptionsInOrder: ValueNotifier(
                                    widget.question.selectedOptionsInOrder));
                          }
                        },
                        question: widget.question,
                      ),
                      IconButton(
                        tooltip: show_history_reportQuestionTranslations[
                            currentLanguageIndex],
                        iconSize: 30,
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
                                          currentLanguageIndex],
                                      style: TextStyle(
                                          fontSize: FontSizes(context).large,
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
                                              show_history_closeTranslations[
                                                  currentLanguageIndex],
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
                                                        milliseconds: 2500),
                                                    () {
                                                  Navigator.of(context).pop();
                                                });
                                                return AlertDialog(
                                                  backgroundColor: Colors.red,
                                                  title: SelectableText(
                                                      show_history_thanksForYourReportTranslations[
                                                          currentLanguageIndex],
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
                                                  currentLanguageIndex],
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
                ),
              ]
            ]),
            trailing: screenWidth < screenHeight
                ? null
                : RainbowButton(
                    onPressed: () {
                      if (widget.question.typeOfQuestion ==
                          TypeOfQuestion.syllogism) {
                        showExplanation(
                          context,
                          widget.question.syllogismType,
                          widget.question.premises.isEmpty ? true : false,
                          widget.question.selectedCorrectOptions,
                          widget.question.selectedIncorrectOptions,
                        );
                      } else {
                        showTestDeduction(context,
                            premises: ValueNotifier(widget.question.premises),
                            conclusions:
                                ValueNotifier(widget.question.conclusions),
                            incorrectConclusions: ValueNotifier(
                                widget.question.incorrectConclusions),
                            selectedCorrectOptions: ValueNotifier(
                                widget.question.selectedCorrectOptions),
                            selectedIncorrectOptions: ValueNotifier(
                                widget.question.selectedIncorrectOptions),
                            sylogismType: widget.question.syllogismType,
                            selectedOptionsInOrder: ValueNotifier(
                                widget.question.selectedOptionsInOrder));
                      }
                    },
                    question: widget.question),
          ),
        ),
      );
    });
  }
}

class RainbowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final dynamic question;

  const RainbowButton({Key? key, required this.onPressed, this.question})
      : super(key: key);

  @override
  _RainbowButtonState createState() => _RainbowButtonState();
}

class _RainbowButtonState extends State<RainbowButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = ColorTween(
      begin: Colors.grey.shade400,
      end: widget.question.isCorrect == AnswerQuestion.correct
          ? Colors.green
          : widget.question.isCorrect == AnswerQuestion.notAnswered
              ? Colors.grey
              : Colors.red,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      int currentLanguageIndex = languageProvider.currentLanguageIndex;
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: _animation.value,
            ),
            child: Text(
                show_history_explicacaoTranslations[currentLanguageIndex],
                style: TextStyle(
                    fontSize: screenWidth > screenHeight
                        ? 18.0
                        : screenHeight * 0.025,
                    color: Colors.white)),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ShowHistory extends StatefulWidget {
  final List<Question> questions;

  const ShowHistory({Key? key, required this.questions}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShowHistoryState createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: questions.reversed.toList().map((question) {
        return QuestionTile(question: question);
      }).toList(),
    );
  }
}

class HoverText extends StatefulWidget {
  final Question question;

  const HoverText({super.key, required this.question});

  @override
  // ignore: library_private_types_in_public_api
  _HoverTextState createState() => _HoverTextState();
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
    1, // Opacity
  );
}

Color getBorderColor(AnswerQuestion isCorrect) {
  return isCorrect == AnswerQuestion.notAnswered
      ? Colors.grey
      : isCorrect == AnswerQuestion.correct
          ? Colors.green
          : Colors.red;
}

class _HoverTextState extends State<HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      int currentLanguageIndex = languageProvider.currentLanguageIndex;
      return MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: SelectableText.rich(
          TextSpan(
            text: widget.question.typeOfQuestion == TypeOfQuestion.deductionTrue
                ? widget.question.syllogismType.contains('Deduction')
                    ? show_history_deductionCorrectConclusionsTranslations[
                        currentLanguageIndex]
                    : '${toTitleCase(widget.question.syllogismType)} -${show_history_correctConclusionsTranslations[currentLanguageIndex]}-'
                : widget.question.typeOfQuestion ==
                        TypeOfQuestion.deductionFalse
                    ? widget.question.syllogismType.contains('Deduction')
                        ? show_history_deductionIncorrectConclusionsTranslations[
                            currentLanguageIndex]
                        : '${toTitleCase(widget.question.syllogismType)} -${show_history_incorrectConclusionsTranslations[currentLanguageIndex]}-'
                    : '${widget.question.syllogismType} Syllogism',
            style: TextStyle(
              fontSize: screenWidth > screenHeight
                  ? FontSizes(context).extraExtraExtraSmall
                  : FontSizes(context).extraSmall,
              color: _isHovering ? getRandomColor() : Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    });
  }
}
