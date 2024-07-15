import 'package:flutter/material.dart';
import 'dart:async';

class TimerText extends StatefulWidget {
  const TimerText({super.key});

  @override
  TimerTextState createState() => TimerTextState();
}

class TimerTextState extends State<TimerText> {
  late Timer _timer;
  int _start = 30;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_start == 0) {
            timer.cancel();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Explanation'),
                  actions: [
                    // Text cancel to cancel the dialog
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        /// if the user presses the button,
                        /// show an explanation of the syllogism in a dialog
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text('Explanation'),
                            content: Text(
                                '''This is an explanation of the Barbara syllogism.
                  
This is because everything that is S falls within the 
category of M, and since everything in M is also P, then everything 
that is S must also be P.'''),
                          ),
                        );
                      },
                      child: const Text(
                          'Do you want an explanation of this syllogism?'),
                    ),
                  ],
                );
              },
            ).then((value) {
              _start = 30;
              startTimer();
            });
          } else if (_start > 0) {
            _start--;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // if the user presses the button and the timer is working,
        // stop it. If the timer is stopped, start it where it left off.
        // if (_timer.isActive) {
        //   _timer.();
        // } else {
        //   startTimer();
        // }
      },
      child: Text(
        'Timer: $_start',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
