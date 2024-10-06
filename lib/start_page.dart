import 'package:flutter/material.dart';
import 'package:new_test/main.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final String _gameName = 'Logisticon';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background5.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Conteúdo principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Título do jogo
                  Text(
                    _gameName,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 80,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black54,
                          offset: Offset(6.0, 6.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  // Coluna com os botões
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Botão 'Start Game' com tamanho fixo
                      SizedBox(
                        width: 250, // Define uma largura fixa
                        height: 60, // Define uma altura fixa
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const LogicalApp()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 10,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 15),
                              Text('Start',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Botão 'Show Rules' com tamanho fixo
                      SizedBox(
                        width: 250, // Define uma largura fixa
                        height: 60, // Define uma altura fixa
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const ShowRules()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 10,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.rule_rounded,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 15),
                              Text('Rules',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Botão 'Exit Game' com tamanho fixo
                      SizedBox(
                        width: 250, // Define uma largura fixa
                        height: 60, // Define uma altura fixa
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 10,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.exit_to_app_rounded,
                                  color: Colors.white, size: 28),
                              SizedBox(width: 15),
                              Text('Exit',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowRules extends StatefulWidget {
  const ShowRules({super.key});

  @override
  ShowRulesState createState() => ShowRulesState();
}

class ShowRulesState extends State<ShowRules> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: const Text('Rules',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                )),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white, size: 32)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 1500,
              height: 500,
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(0.6), // fundo branco translúcido
                borderRadius: BorderRadius.circular(10), // bordas arredondadas
              ),
              padding:
                  const EdgeInsets.all(16.0), // padding interno para o texto
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Align(
                        child: Text(
                          'Game Rules',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'The game is based on syllogisms, which are logical arguments that apply deductive reasoning to arrive at a conclusion based on two premises. A syllogism is valid if the conclusion follows logically from the premises.',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'The game will present you with a syllogism, and you will have to determine which one is valid.',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• If you think it is valid, select the option and press the "Verify" button.',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• If you want an explanation of the syllogism, press the "(?)" button.',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• If you want to see your history, press the "Clock" button.',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
