import 'package:flutter/material.dart';
import 'package:new_test/main.dart';
import 'package:new_test/show_explanation.dart';

class Question {
  final String majorPremise;
  final String minorPremise;
  final List<dynamic> premises;
  final String rightChoice;
  final String userChoice;
  final String syllogismType;
  final AnswerQuestion isCorrect;

  Question({
    required this.majorPremise,
    required this.minorPremise,
    required this.premises,
    required this.userChoice,
    required this.rightChoice,
    required this.syllogismType,
    required this.isCorrect,
  });
}

class ShowHistory extends StatelessWidget {
  final List<Question> questions;

  const ShowHistory({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: questions.reversed.toList().map((question) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Icon(
              question.isCorrect == AnswerQuestion.correct
                  ? Icons.check
                  : Icons.close,
              color: question.isCorrect == AnswerQuestion.correct
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text(
              question.majorPremise != 'none'
                  ? '${question.syllogismType} Syllogism'
                  : 'Modus Ponens',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (question.premises.isNotEmpty) ...[
                  const Text(
                    'Premises: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  for (var premise in question.premises) ...[
                    Text(
                      '${'- ' + premise}.',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ] else ...[
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18.0),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Major Premise: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: question.majorPremise,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18.0),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Minor Premise: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: question.minorPremise,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18.0, color: Colors.green),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Conclusion: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: question.rightChoice,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 18.0,
                        color: question.isCorrect == AnswerQuestion.correct
                            ? Colors.green
                            : Colors.red),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Selected: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: question.isCorrect == AnswerQuestion.notAnswered
                              ? 'Not Answered'
                              : question.userChoice),
                    ],
                  ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showExplanation(context, question.syllogismType);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text('Explain',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
