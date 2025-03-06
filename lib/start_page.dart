import 'package:flutter/material.dart';
import 'package:new_test/font_size.dart';
import 'package:new_test/main.dart';
import 'package:new_test/choose_language.dart';
import 'package:new_test/show_history.dart';
import 'package:new_test/truth_table/lang_code_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_language.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

// import 'package:new_test/font_size.dart';

class StartPage extends StatefulWidget {
  final bool gameActive;
  StartPage({
    super.key,
    required this.gameActive,
  });

  @override
  StartPageState createState() => StartPageState();
}

final Map<int, String> chooseOptionTranslations = {
  0: 'اختر خيارًا', // Árabe
  1: '选择一个选项', // Mandarim
  2: 'Wähle eine Option', // Alemão
  3: 'Choose an option', // Inglês
  4: 'Choisissez une option', // Francês
  5: 'एक विकल्प चुनें', // Hindi
  6: 'オプションを選択してください', // Japonês
  7: 'Escolha uma opção', // Português
  8: 'Elige una opción', // Espanhol
};

class StartPageState extends State<StartPage> {
  final String _gameName = 'Logisticon';
  final List<String> startGameTranslations = [
    'ابدأ اللعبة', // Arabic
    '开始游戏', // Mandarin
    'Spiel starten', // Alemão
    'Start Game', // Inglês
    'Commencer le jeu', // Francês
    'खेल शुरू करें', // Hindi
    'ゲーム開始', // Japonês
    'Iniciar jogo', // Português
    'Iniciar juego', // Espanhol
  ];

  @override
  Widget build(BuildContext context) {
    // Acessa o idioma atual via Provider
    int currentLanguageIndex =
        Provider.of<LanguageProvider>(context).currentLanguageIndex;
    String startGameText = startGameTranslations[currentLanguageIndex];

    // Tradução para o texto "Choose an option" baseado no idioma atual
    String chooseOptionText =
        chooseOptionTranslations[currentLanguageIndex] ?? 'Choose an option';

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 143, 218, 253),
                const Color.fromARGB(255, 58, 172, 238),
                const Color.fromARGB(255, 4, 85, 151),
              ],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 700,
              ),
              child: Container(
                height: screenHeight * 0.5,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                decoration: BoxDecoration(
                  border: screenWidth > screenHeight
                      ? Border.all(
                          color: Colors.white,
                          width: 5,
                        )
                      : null,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: screenWidth > screenHeight
                        ? [
                            Colors.lightBlue,
                            Colors.blue,
                            Colors.blue.shade900,
                          ]
                        : [
                            Colors.transparent,
                            Colors.transparent,
                          ],
                  ),
                  boxShadow: screenWidth > screenHeight
                      ? const [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 10.0,
                            spreadRadius: 10.0,
                          ),
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Título do jogo
                    SelectableText(
                      maxLines: 1,
                      _gameName,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: screenWidth > screenHeight
                            ? 82
                            : screenWidth * 0.15 + 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.white,
                            //offset: Offset(4.0, 1.0),
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
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (widget.gameActive) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: Colors.white,
                                      title: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          SelectableText(
                                            chooseOptionText,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  FontSizes(context).large,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 20.0),
                                      actionsPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                      actions: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  clearQuestions();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .popUntil((route) =>
                                                          route.isFirst);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LogicalApp(
                                                              gameActive:
                                                                  false),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: BorderSide
                                                              .strokeAlignCenter +
                                                          5),
                                                ),
                                                child: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    Start_page_newGameTranslations[
                                                        currentLanguageIndex],
                                                    style: TextStyle(
                                                      fontSize: FontSizes(
                                                              context)
                                                          .medium, // Define um tamanho máximo inicial
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Fechar diálogo
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LogicalApp(
                                                              gameActive: true),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.lightBlueAccent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: BorderSide
                                                          .strokeAlignCenter),
                                                ),
                                                child: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    Start_page_continueTranslations[
                                                        currentLanguageIndex],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          FontSizes(context)
                                                              .medium,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LogicalApp(gameActive: false),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              shadowColor: Colors.blue,
                              elevation: 10,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                              child: AutoSizeText(
                                startGameText,
                                style: TextStyle(
                                  fontSize:
                                      28, // Define um tamanho máximo inicial
                                  color: Colors.white,
                                ),
                                maxLines:
                                    1, // Garante que o texto ocupará no máximo uma linha
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Botão 'Show Rules' com tamanho fixo
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ShowRules()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              shadowColor: Colors.blue,
                              elevation: 10,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 200, 0),
                                  child: Icon(Icons.rule_rounded,
                                      color: Colors.white, size: 30),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                  child: AutoSizeText(
                                    Start_page_ruleTranslations[
                                        currentLanguageIndex],
                                    style: TextStyle(
                                      fontSize:
                                          28, // Define um tamanho máximo inicial
                                      color: Colors.white,
                                    ),
                                    maxLines:
                                        1, // Garante que o texto ocupará no máximo uma linha
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                            height: 60,
                            child:
                                ChooseLanguage(languages: getLanguagesCode())),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: Stack(
                            children: [
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade900,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    shadowColor: Colors.blue.shade800,
                                    elevation: 10,
                                  ),
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 200, 0),
                                          child: Icon(Icons.exit_to_app_rounded,
                                              color: Colors.white, size: 30),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 3),
                                          child: Text(
                                              Start_page_exitTranslations[
                                                  currentLanguageIndex],
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  color: Colors.white)),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
    FontSizes fontSizes = FontSizes(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.amber, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return Text(
                  show_rules_gameRulesTranslations[
                      languageProvider.currentLanguageIndex],
                  style: TextStyle(
                    fontSize: FontSizes(context).large,
                    color: Colors.white,
                  ),
                );
              },
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white, size: 32)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    // A partir daqui, você pode acessar as traduções usando languageProvider
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            child: SelectableText(
                              show_rules_gameRulesTranslations[
                                  languageProvider.currentLanguageIndex],
                              style: TextStyle(
                                fontSize: screenWidth > screenHeight
                                    ? fontSizes.extraExtraExtraLarge
                                    : fontSizes.extraLarge,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              SelectableText(
                                show_rules_gameDescriptionTranslations[
                                    languageProvider
                                        .currentLanguageIndex], // Exemplo de substituição
                                style: TextStyle(
                                    fontSize: screenWidth > screenHeight
                                        ? fontSizes.medium
                                        : fontSizes.small,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                show_rules_gameObjectiveTranslations[
                                    languageProvider
                                        .currentLanguageIndex], // Outro exemplo
                                style: TextStyle(
                                    fontSize: screenWidth > screenHeight
                                        ? fontSizes.medium
                                        : fontSizes.small,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                show_rules_instructionsTranslations[
                                    languageProvider.currentLanguageIndex],
                                style: TextStyle(
                                    fontSize: screenWidth > screenHeight
                                        ? fontSizes.medium
                                        : fontSizes.small,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                show_rules_explanationButtonTranslations[
                                    languageProvider.currentLanguageIndex],
                                style: TextStyle(
                                    fontSize: screenWidth > screenHeight
                                        ? fontSizes.medium
                                        : fontSizes.small,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                Show_rules_historyButtonTranslations[
                                    languageProvider.currentLanguageIndex],
                                style: TextStyle(
                                    fontSize: screenWidth > screenHeight
                                        ? fontSizes.medium
                                        : fontSizes.small,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
