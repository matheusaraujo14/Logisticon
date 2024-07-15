import 'package:flutter/material.dart';
import 'package:new_test/main.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final String _gameName = 'Logicon';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Logicon'),
        // ),  // Builder(builder: (BuildContext context) { return ... } )
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(height: 100),
                Text(
                  _gameName,
                  style: const TextStyle(fontFamily: 'Oswald', fontSize: 60),
                ),
                const SizedBox(height: 200),
                //  a row with three buttons: one for starting the game,
                //  one for showing the rules, and one for exiting the game
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // a button with text 'Start game' that starts the game
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/game');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LogicalApp()));
                      },
                      child: const Text('Start game'),
                    ),
                    const SizedBox(width: 20),
                    // a button with text 'Show rules' that shows the rules
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowRules()));
                      },
                      child: const Text('Show rules'),
                    ),
                    const SizedBox(width: 20),
                    // a button with text 'Exit game' that exits the game
                    ElevatedButton(
                      onPressed: () {
                        // exit the App by popping up all routes
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Exit game'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// create a stateful widget called ShowRules
class ShowRules extends StatefulWidget {
  const ShowRules({super.key});

  @override
  ShowRulesState createState() => ShowRulesState();
}

class ShowRulesState extends State<ShowRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rules')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // a text widget with the rules of the game
            const Text(
                '''The rules of the game are simple. You will be presented with a 
                  syllogism, and you will have to determine whether it is valid 
                  or invalid. If you think it is valid, press the 'Valid' button. If 
                  you think it is invalid, press the 'Invalid' button. If you want 
                  an explanation of the syllogism, press the 'Explanation' button.'''),
            const SizedBox(height: 20),
            // a button with text 'Back' that goes back to the start page
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
