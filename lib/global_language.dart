import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  int _currentLanguageIndex =
      3; // Valor inicial do idioma, por exemplo, Inglês (3)

  int get currentLanguageIndex => _currentLanguageIndex;

  // Método para alterar o idioma
  void setLanguage(int newIndex) {
    _currentLanguageIndex = newIndex;

    notifyListeners(); // Notifica os ouvintes para atualizar a interface
  }
}

final List<String> skipTranslations = [
  // Árabe
  "تخطي",
  // Mandarim
  "跳过",
  // Alemão
  "Überspringen",
  // Inglês
  "Skip",
  // Francês
  "Passer",
  // Hindi
  "छोड़ें",
  // Japonês
  "スキップ",
  // Português
  "Pular",
  // Espanhol
  "Saltar"
];

final List<String> backTranslations = [
  // Árabe
  "عودة",
  // Mandarim
  "返回",
  // Alemão
  "Zurück",
  // Inglês
  "Back",
  // Francês
  "Retour",
  // Hindi
  "वापस",
  // Japonês
  "戻る",
  // Português
  "Voltar",
  // Espanhol
  "Atrás"
];

final List<String> Start_page_newGameTranslations = [
  'لعبة جديدة', // Árabe
  '新游戏', // Mandarim
  'Neues Spiel', // Alemão
  'New Game', // Inglês
  'Nouveau jeu', // Francês
  'नया खेल', // Hindi
  '新しいゲーム', // Japonês
  'Novo jogo', // Português
  'Nuevo juego', // Espanhol
];

final List<String> Start_page_continueTranslations = [
  'تابع', // Árabe
  '继续', // Mandarim
  'Fortsetzen', // Alemão
  'Continue', // Inglês
  'Continuer', // Francês
  'जारी रखें', // Hindi
  '続ける', // Japonês
  'Continuar', // Português
  'Continuar', // Espanhol
];

final List<String> Start_page_ruleTranslations = [
  'قانون', // Árabe
  '规则', // Mandarim
  'Regel', // Alemão
  'Rules', // Inglês
  'Règle', // Francês
  'नियम', // Hindi
  'ルール', // Japonês
  'Regras', // Português
  'Regla', // Espanhol
];

final List<String> Start_page_exitTranslations = [
  'خروج', // Árabe
  '退出', // Mandarim
  'Beenden', // Alemão
  'Exit', // Inglês
  'Quitter', // Francês
  'बाहर जाएं', // Hindi
  '終了', // Japonês
  'Sair', // Português
  'Salir', // Espanhol
];

final List<String> show_rules_gameRulesTranslations = [
  'قواعد اللعبة', // Árabe
  '游戏规则', // Mandarim
  'Spielregeln', // Alemão
  'Game Rules', // Inglês
  'Règles du jeu', // Francês
  'खेल के नियम', // Hindi
  'ゲームのルール', // Japonês
  'Regras do jogo', // Português
  'Reglas del juego', // Espanhol
];

final List<String> show_rules_gameDescriptionTranslations = [
  'تستند اللعبة إلى استنتاجات أرسطو وقياساته المنطقية، وهي حجج منطقية تستخدم الاستنتاج للوصول إلى نتيجة بناءً على مقدمتين. يكون القياس صحيحًا إذا كانت النتيجة تتبع منطقياً من المقدمات.', // Árabe
  '该游戏基于亚里士多德的推论和三段论，这是通过演绎推理根据两个前提得出结论的逻辑论证。如果结论逻辑上符合前提，则三段论有效。', // Mandarim
  'Das Spiel basiert auf aristotelischen Schlussfolgerungen und Syllogismen, bei denen es sich um logische Argumente handelt, die deduktives Denken anwenden, um auf der Grundlage zweier Prämissen zu einer Schlussfolgerung zu gelangen. Ein Syllogismus ist gültig, wenn die Schlussfolgerung logisch aus den Prämissen folgt.', // Alemão
  'The game is based on Aristotelian deductions and syllogisms, which are logical arguments that apply deductive reasoning to arrive at a conclusion based on two premises. A syllogism is valid if the conclusion follows logically from the premises.', // Inglês
  'Le jeu est basé sur les déductions aristotéliciennes et les syllogismes, qui sont des arguments logiques appliquant le raisonnement déductif pour arriver à une conclusion basée sur deux prémisses. Un syllogisme est valide si la conclusion suit logiquement les prémisses.', // Francês
  'यह खेल अरस्तू के निष्कर्षों और निगमन विधि पर आधारित है, जो कि दो प्रस्तावों के आधार पर निष्कर्ष तक पहुँचने के लिए तर्क का उपयोग करता है। यदि निष्कर्ष प्रस्तावों से तार्किक रूप से आता है, तो निगमन विधि मान्य है।', // Hindi
  'このゲームはアリストテレスの推論と三段論法に基づいており、これは2つの前提に基づいて結論に到達するために演繹的推論を適用する論理的な議論です。結論が前提から論理的に導き出される場合、三段論法は有効です。', // Japonês
  'O jogo é baseado nas deduções aristotélicas e nos silogismos, que são argumentos lógicos que aplicam o raciocínio dedutivo para chegar a uma conclusão com base em duas premissas. Um silogismo é válido se a conclusão seguir logicamente das premissas.', // Português
  'El juego se basa en las deducciones aristotélicas y los silogismos, que son argumentos lógicos que aplican el razonamiento deductivo para llegar a una conclusión basada en dos premisas. Un silogismo es válido si la conclusión sigue lógicamente de las premisas.', // Espanhol
];

final List<String> show_rules_gameObjectiveTranslations = [
  'ستعرض لك اللعبة قياسًا منطقيًا أو استنتاجًا، وعليك تحديد أي من الخيارات أدناه صحيح.', // Árabe
  '游戏将为您呈现一个三段论或推论，您需要确定以下选项中哪个是有效的。', // Mandarim
  'Das Spiel wird Ihnen einen Syllogismus oder eine Schlussfolgerung präsentieren, und Sie müssen bestimmen, welche der untenstehenden Optionen gültig ist.', // Alemão
  'The game will present you with a syllogism or a deduction, and you will have to determine which one of the options below is valid.', // Inglês
  'Le jeu vous présentera un syllogisme ou une déduction, et vous devrez déterminer laquelle des options ci-dessous est valide.', // Francês
  'खेल आपको एक निगमन विधि या निष्कर्ष प्रस्तुत करेगा, और आपको यह निर्धारित करना होगा कि नीचे दिए गए विकल्पों में से कौन सा मान्य है।', // Hindi
  'ゲームはあなたに三段論法または推論を提示し、以下のオプションのうちどれが有効かを判断する必要があります。', // Japonês
  'O jogo apresentará a você um silogismo ou uma dedução, e você terá que determinar qual das opções abaixo é válida.', // Português
  'El juego te presentará un silogismo o una deducción, y tendrás que determinar cuál de las opciones a continuación es válida.', // Espanhol
];
final List<String> show_rules_instructionsTranslations = [
  '• للتحقق من الصحة، اختر الخيارات واضغط على زر "تحقق".', // Árabe
  '• 若要验证，请选择选项并按下“验证”按钮。', // Mandarim
  '• Um die Gültigkeit zu überprüfen, wählen Sie die Optionen und drücken Sie die Schaltfläche „Überprüfen“.', // Alemão
  '• To verify, select the options and press the "Verify" button.', // Inglês
  '• Pour vérifier, sélectionnez les options et appuyez sur le bouton "Vérifier".', // Francês
  '• सत्यापन के लिए, विकल्प चुनें और "सत्यापित करें" बटन दबाएं।', // Hindi
  '• 検証するには、オプションを選択し、「確認」ボタンを押してください。', // Japonês
  '• Para verificar, selecione as opções e pressione o botão "Verificar".', // Português
  '• Para verificar, selecciona las opciones y presiona el botón "Verificar".', // Espanhol
];

final List<String> show_rules_explanationButtonTranslations = [
  '• لشرح القياس المنطقي/الاستنتاج، اضغط على زر "(?)".', // Árabe
  '• 若要获取三段论/推论的解释，请按“(?)”按钮。', // Mandarim
  '• Um eine Erklärung des Syllogismus/der Schlussfolgerung zu erhalten, drücken Sie die Schaltfläche "(?)".', // Alemão
  '• To get an explanation of the syllogism/deduction, press the "(?)" button.', // Inglês
  '• Pour une explication du syllogisme/de la déduction, appuyez sur le bouton "(?)".', // Francês
  '• निगमन विधि/निष्कर्ष का स्पष्टीकरण पाने के लिए "(?)" बटन दबाएं।', // Hindi
  '• 三段論法や推論の説明を確認するには、「(?)」ボタンを押してください。', // Japonês
  '• Para obter uma explicação do silogismo/dedução, pressione o botão "(?)".', // Português
  '• Para obtener una explicación del silogismo/deducción, presiona el botón "(?)".', // Espanhol
];

final List<String> Show_rules_historyButtonTranslations = [
  '• لعرض التاريخ، اضغط على زر "الساعة".', // Árabe
  '• 若要查看历史记录，请按“时钟”按钮。', // Mandarim
  '• Um den Verlauf anzuzeigen, drücken Sie die Schaltfläche "Uhr".', // Alemão
  '• To see the history, press the "Clock" button.', // Inglês
  '• Pour voir l\'historique, appuyez sur le bouton "Horloge".', // Francês
  '• इतिहास देखने के लिए "घड़ी" बटन दबाएं।', // Hindi
  '• 履歴を表示するには、「時計」ボタンを押してください。', // Japonês
  '• Para ver o histórico, pressione o botão "Relógio".', // Português
  '• Para ver el historial, presiona el botón "Reloj".', // Espanhol
];

final List<String> main_syllogismsTranslations = [
  'القياسات المنطقية', // Árabe
  '三段论', // Mandarim
  'Syllogismen', // Alemão
  'Syllogisms', // Inglês
  'Syllogismes', // Francês
  'निगमन विधियाँ', // Hindi
  '三段論法', // Japonês
  'Silogismos', // Português
  'Silogismos', // Espanhol
];

final List<String> main_correctTranslations = [
  'صحيح', // Árabe
  '正确', // Mandarim
  'Korrekt', // Alemão
  'Correct', // Inglês
  'Correct', // Francês
  'सही', // Hindi
  '正しい', // Japonês
  'Correto', // Português
  'Correcto', // Espanhol
];

final List<String> main_currentComboTranslations = [
  'التركيبة الحالية:', // Árabe
  '当前组合:', // Mandarim
  'Aktuelle Kombination:', // Alemão
  'Current Combo:', // Inglês
  'Combo actuel:', // Francês
  'वर्तमान संयोजन:', // Hindi
  '現在のコンボ:', // Japonês
  'Combo atual:', // Português
  'Combinación actual:', // Espanhol
];

final List<String> main_yourBestTranslations = [
  'أفضل ما لديك:', // Árabe
  '你的最好:', // Mandarim
  'Dein Bestes:', // Alemão
  'Your Best:', // Inglês
  'Votre meilleur :', // Francês
  'आपका सर्वश्रेष्ठ:', // Hindi
  'あなたのベスト:', // Japonês
  'O seu melhor:', // Português
  'Tu mejor:', // Espanhol
];

final List<String> main_correctAnswerTranslations = [
  'الإجابة الصحيحة', // Árabe
  '正确答案', // Mandarim
  'Richtige Antwort', // Alemão
  'Correct answer', // Inglês
  'Réponse correcte', // Francês
  'सही उत्तर', // Hindi
  '正しい答え', // Japonês
  'Resposta correta', // Português
  'Respuesta correcta', // Espanhol
];

final List<String> main_incorrectAnswerTranslations = [
  'إجابة غير صحيحة', // Árabe
  '错误答案', // Mandarim
  'Falsche Antwort', // Alemão
  'Incorrect answer', // Inglês
  'Réponse incorrecte', // Francês
  'गलत उत्तर', // Hindi
  '間違った答え', // Japonês
  'Resposta incorreta', // Português
  'Respuesta incorrecta', // Espanhol
];

final List<String> main_notAnsweredTranslations = [
  'لم تتم الإجابة', // Árabe
  '未回答', // Mandarim
  'Nicht beantwortet', // Alemão
  'Not answered', // Inglês
  'Non répondu', // Francês
  'उत्तर नहीं दिया गया', // Hindi
  '未回答', // Japonês
  'Não respondido', // Português
  'No respondido', // Espanhol
];

final List<String> main_errorTranslations = [
  'خطأ', // Árabe
  '错误', // Mandarim
  'Fehler', // Alemão
  'Error', // Inglês
  'Erreur', // Francês
  'त्रुटि', // Hindi
  'エラー', // Japonês
  'Erro', // Português
  'Error', // Espanhol
];

final List<String> main_verifyTranslations = [
  'تحقق', // Árabe
  '验证', // Mandarim
  'Überprüfen', // Alemão
  'Verify', // Inglês
  'Vérifier', // Francês
  'सत्यापित करें', // Hindi
  '確認する', // Japonês
  'Verificar', // Português
  'Verificar', // Espanhol
];

final List<String> main_explanationQuestionTranslations = [
  'هل تريد شرحًا لهذا القياس المنطقي؟', // Árabe
  '您想要这个三段论的解释吗？', // Mandarim
  'Möchten Sie eine Erklärung dieses Syllogismus?', // Alemão
  'Do you want an explanation of this syllogism?', // Inglês
  'Voulez-vous une explication de ce syllogisme ?', // Francês
  'क्या आप इस निगमन विधि का स्पष्टीकरण चाहते हैं?', // Hindi
  'この三段論法の説明が欲しいですか？', // Japonês
  'Você quer uma explicação deste silogismo?', // Português
  '¿Quieres una explicación de este silogismo?', // Espanhol
];

final List<String> main_explanationDeductionQuestionTranslations = [
  'هل تريد شرحًا لهذا الاستنتاج؟', // Árabe
  '您想要这个推论的解释吗？', // Mandarim
  'Möchten Sie eine Erklärung dieser Schlussfolgerung?', // Alemão
  'Do you want an explanation of this deduction?', // Inglês
  'Voulez-vous une explication de cette déduction ?', // Francês
  'क्या आप इस निष्कर्ष का स्पष्टीकरण चाहते हैं?', // Hindi
  'この推論の説明が欲しいですか？', // Japonês
  'Você quer uma explicação desta dedução?', // Português
  '¿Quieres una explicación de esta deducción?', // Espanhol
];

final List<String> main_noTranslations = [
  'لا', // Árabe
  '没有', // Mandarim
  'Nein', // Alemão
  'NO', // Inglês
  'NON', // Francês
  'नहीं', // Hindi
  'いいえ', // Japonês
  'Não', // Português
  'No', // Espanhol
];

final List<String> main_yesTranslations = [
  'نعم', // Árabe
  '是', // Mandarim
  'Ja', // Alemão
  'YES', // Inglês
  'OUI', // Francês
  'हाँ', // Hindi
  'はい', // Japonês
  'Sim', // Português
  'Sí', // Espanhol
];

final List<String> main_historicoTranslations = [
  'التاريخ', // Árabe
  '历史', // Mandarim
  'Verlauf', // Alemão
  'History', // Inglês
  'Historique', // Francês
  'इतिहास', // Hindi
  '履歴', // Japonês
  'Histórico', // Português
  'Historial', // Espanhol
];

final List<String> main_noQuestionsAnsweredYetTranslations = [
  'لم يتم الإجابة على أي أسئلة بعد.', // Árabe
  '尚未回答任何问题。', // Mandarim
  'Noch keine Fragen beantwortet.', // Alemão
  'No questions answered yet.', // Inglês
  'Aucune question n\'a encore été répondue.', // Francês
  'अभी तक कोई प्रश्न उत्तरित नहीं हुए हैं।', // Hindi
  'まだ質問には答えていません。', // Japonês
  'Ainda não foram respondidas perguntas.', // Português
  'Aún no se han respondido preguntas.', // Espanhol
];

final List<String> main_okTranslations = [
  'حسنًا', // Árabe
  '好的', // Mandarim
  'OK', // Alemão
  'OK', // Inglês
  'D\'accord', // Francês
  'ठीक है', // Hindi
  'OK', // Japonês
  'OK', // Português
  'OK', // Espanhol
];

final List<String> show_question_chooseCorrectConclusionTranslations = [
  "اختر الاستنتاج الصحيح لهذا القياس المنطقي", // Árabe
  "为以下三段论选择正确的结论", // Mandarim
  "Wählen Sie die RICHTIGE Schlussfolgerung für den folgenden Syllogismus", // Alemão
  "Choose the CORRECT conclusion for the following syllogism", // Inglês
  "Choisissez la CONCLUSION CORRECTE pour le syllogisme suivant", // Francês
  "निम्नलिखित न्याय के लिए सही निष्कर्ष चुनें", // Hindi
  "次の三段論法に対して正しい結論を選択してください", // Japonês
  "Escolha a conclusão CORRETA para o seguinte silogismo", // Português
  "Elija la conclusión CORRECTA para el siguiente silogismo" // Espanhol
];

final List<String> show_question_chooseCorrectConclusionDeductionTranslations =
    [
  "اختر الاستنتاج (الاستنتاجات) الصحيح (ة) للمقدمات التالية", // Árabe
  "为以下前提选择正确的结论", // Mandarim
  "Wählen Sie die RICHTIGEN Schlussfolgerung(en) für die folgenden Prämissen", // Alemão
  "Choose the CORRECT conclusion(S) for the following premises", // Inglês
  "Choisissez la ou les conclusion(s) CORRECTE(S) pour les prémisses suivantes", // Francês
  "निम्नलिखित प्रस्थापनाओं के लिए सही निष्कर्ष(ओं) का चयन करें", // Hindi
  "次の前提に対して正しい結論を選択してください", // Japonês
  "Escolha a(s) conclusão(ões) CORRETA(S) para as premissas a seguir", // Português
  "Elija la(s) conclusión(es) CORRECTA(S) para las siguientes premisas" // Espanhol
];

final List<String>
    show_question_chooseIncorrectConclusionDeductionTranslations = [
  "اختر الاستنتاج (الاستنتاجات) غير الصحيح (ة) للمقدمات التالية", // Árabe
  "为以下前提选择错误的结论", // Mandarim
  "Wählen Sie die FALSCHEN Schlussfolgerung(en) für die folgenden Prämissen", // Alemão
  "Choose the INCORRECT conclusion(S) for the following premises", // Inglês
  "Choisissez la ou les conclusion(s) INCORRECTE(S) pour les prémisses suivantes", // Francês
  "निम्नलिखित प्रस्थापनाओं के लिए गलत निष्कर्ष(ओं) का चयन करें", // Hindi
  "次の前提に対して間違った結論を選択してください", // Japonês
  "Escolha a(s) conclusão(ões) INCORRETA(S) para as premissas a seguir", // Português
  "Elija la(s) conclusión(es) INCORRECTA(S) para las siguientes premisas" // Espanhol
];

final List<String> show_question_majorPremiseTranslations = [
  'الفرضية الرئيسية: ', // Árabe
  '主要前提: ', // Mandarim
  'Hauptprämisse: ', // Alemão
  'Major premise: ', // Inglês
  'Premisse principale: ', // Francês
  'मुख्य प्रमिस: ', // Hindi
  '主要前提: ', // Japonês
  'Premissa maior: ', // Português
  'Premisa mayor: ', // Espanhol
];

final List<String> show_question_minorPremiseTranslations = [
  'الفرضية الثانوية: ', // Árabe
  '次要前提: ', // Mandarim
  'Nebenprämisse: ', // Alemão
  'Minor premise: ', // Inglês
  'Prémisse mineure: ', // Francês
  'सूक्ष्म प्रमिस: ', // Hindi
  '小前提: ', // Japonês
  'Premissa menor: ', // Português
  'Premisa menor: ', // Espanhol
];

final List<String> show_history_reportQuestionTranslations = [
  'هل تريد الإبلاغ عن هذا السؤال؟', // Árabe
  '您想报告这个问题吗？', // Mandarim
  'Möchten Sie diese Frage melden?', // Alemão
  'Do you want to report this question?', // Inglês
  'Voulez-vous signaler cette question ?', // Francês
  'क्या आप इस प्रश्न की रिपोर्ट करना चाहते हैं?', // Hindi
  'この質問を報告しますか？', // Japonês
  'Você quer reportar esta pergunta?', // Português
  '¿Quieres reportar esta pregunta?', // Espanhol
];

final List<String> show_history_closeTranslations = [
  'إغلاق', // Árabe
  '关闭', // Mandarim
  'Schließen', // Alemão
  'Close', // Inglês
  'Fermer', // Francês
  'बंद करें', // Hindi
  '閉じる', // Japonês
  'Fechar', // Português
  'Cerrar', // Espanhol
];

final List<String> show_history_thanksForYourReportTranslations = [
  'شكرًا لتقريرك', // Árabe
  '感谢您的报告', // Mandarim
  'Danke für Ihren Bericht', // Alemão
  'Thanks for your report', // Inglês
  'Merci pour votre rapport', // Francês
  'आपकी रिपोर्ट के लिए धन्यवाद', // Hindi
  '報告ありがとうございます', // Japonês
  'Obrigado pelo seu relatório', // Português
  'Gracias por su informe', // Espanhol
];

final List<String> show_history_reportTranslations = [
  'تقرير', // Árabe
  '报告', // Mandarim
  'Bericht', // Alemão
  'Report', // Inglês
  'Rapport', // Francês
  'रिपोर्ट', // Hindi
  '報告', // Japonês
  'Relatório', // Português
  'Informe', // Espanhol
];

final List<String> show_history_premisesTranslations = [
  'المقدمات:', // Árabe
  '前提：', // Mandarim
  'Prämissen:', // Alemão
  'Premises: ', // Inglês
  'Prémisses :', // Francês
  'प्रस्तावना: ', // Hindi
  '前提：', // Japonês
  'Premissas: ', // Português
  'Premisas: ', // Espanhol
];

final List<String> show_history_majorPremiseTranslations = [
  'الفرضية الرئيسية:', // Árabe
  '主要前提：', // Mandarim
  'Hauptprämisse:', // Alemão
  'Major Premise: ', // Inglês
  'Premisse principale :', // Francês
  'मुख्य प्रमिस: ', // Hindi
  '主要前提：', // Japonês
  'Premissa maior: ', // Português
  'Premisa mayor: ', // Espanhol
];

final List<String> show_history_minorPremiseTranslations = [
  'الفرضية الثانوية:', // Árabe
  '次要前提：', // Mandarim
  'Nebenprämisse:', // Alemão
  'Minor Premise: ', // Inglês
  'Prémisse mineure :', // Francês
  'सूक्ष्म प्रमिस: ', // Hindi
  '小前提：', // Japonês
  'Premissa menor: ', // Português
  'Premisa menor: ', // Espanhol
];

final List<String> show_history_conclusionTranslations = [
  'الاستنتاج:', // Árabe
  '结论：', // Mandarim
  'Schlussfolgerung:', // Alemão
  'Conclusion: ', // Inglês
  'Conclusion :', // Francês
  'निष्कर्ष: ', // Hindi
  '結論：', // Japonês
  'Conclusão: ', // Português
  'Conclusión: ', // Espanhol
];

final List<String> show_history_incorrectConclusionTranslations = [
  'الاستنتاج غير الصحيح', // Árabe
  '错误的结论', // Mandarim
  'Falsche Schlussfolgerung', // Alemão
  'Incorrect Conclusion', // Inglês
  'Conclusion incorrecte', // Francês
  'गलत निष्कर्ष', // Hindi
  '不正しい結論', // Japonês
  'Conclusão incorreta', // Português
  'Conclusión incorrecta', // Espanhol
];

final List<String> show_history_selectedTranslations = [
  'محدد:', // Árabe
  '已选择：', // Mandarim
  'Ausgewählt:', // Alemão
  'Selected: ', // Inglês
  'Sélectionné :', // Francês
  'चयनित:', // Hindi
  '選択された：', // Japonês
  'Selecionado: ', // Português
  'Seleccionado: ', // Espanhol
];

final List<String> show_history_notAnsweredTranslations = [
  'لم تتم الإجابة', // Árabe
  '未回答', // Mandarim
  'Nicht beantwortet', // Alemão
  'Not Answered', // Inglês
  'Non répondu', // Francês
  'उत्तर नहीं दिया गया', // Hindi
  '未回答', // Japonês
  'Não Respondido', // Português
  'No respondido', // Espanhol
];

final List<String> show_history_explicacaoTranslations = [
  'الشرح', // Árabe
  '解释', // Mandarim
  'Erklärung', // Alemão
  'Explanation', // Inglês
  'Explication', // Francês
  'व्याख्या', // Hindi
  '説明', // Japonês
  'Explicação', // Português
  'Explicación', // Espanhol
];

final List<String> show_history_deductionCorrectConclusionsTranslations = [
  'الاستنتاج - الاستنتاجات الصحيحة -', // Árabe
  '推理 - 正确的结论 -', // Mandarim
  'Deduktion - Korrekte Schlussfolgerungen -', // Alemão
  'Deduction - Correct Conclusions -', // Inglês
  'Déduction - Conclusions correctes -', // Francês
  'निगमन - सही निष्कर्ष -', // Hindi
  '推論 - 正しい結論 -', // Japonês
  'Dedução - Conclusões corretas -', // Português
  'Deducción - Conclusiones correctas -', // Espanhol
];

final List<String> show_history_correctConclusionsTranslations = [
  'الاستنتاجات الصحيحة', // Árabe
  '正确的结论', // Mandarim
  'Korrekte Schlussfolgerungen', // Alemão
  'Correct Conclusions', // Inglês
  'Conclusions correctes', // Francês
  'सही निष्कर्ष', // Hindi
  '正しい結論', // Japonês
  'Conclusões corretas', // Português
  'Conclusiones correctas', // Espanhol
];

final List<String> show_history_deductionIncorrectConclusionsTranslations = [
  'الاستنتاج - الاستنتاجات غير الصحيحة -', // Árabe
  '推理 - 错误的结论 -', // Mandarim
  'Deduktion - Falsche Schlussfolgerungen -', // Alemão
  'Deduction - Incorrect Conclusions -', // Inglês
  'Déduction - Conclusions incorrectes -', // Francês
  'निगमन - गलत निष्कर्ष -', // Hindi
  '推論 - 誤った結論 -', // Japonês
  'Dedução - Conclusões incorretas -', // Português
  'Deducción - Conclusiones incorrectas -', // Espanhol
];

final List<String> show_history_incorrectConclusionsTranslations = [
  'الاستنتاجات غير الصحيحة', // Árabe
  '错误的结论', // Mandarim
  'Falsche Schlussfolgerungen', // Alemão
  'Incorrect Conclusions', // Inglês
  'Conclusions incorrectes', // Francês
  'गलत निष्कर्ष', // Hindi
  '誤った結論', // Japonês
  'Conclusões incorretas', // Português
  'Conclusiones incorrectas', // Espanhol
];

final List<String> syllogismExplanationTranslations_SH_Explanation = [
  'هذا شرح لمذهب', // Árabe
  '这是 三段论的解释', // Mandarim
  'Dies ist eine Erklärung des Syllogismus', // Alemão
  'This is an explanation of the Syllogism', // Inglês
  'Ceci est une explication du syllogisme', // Francês
  'यह तर्कशास्त्र की व्याख्या है', // Hindi
  'これは 三段論法の説明です', // Japonês
  'Esta é uma explicação do Silogismo', // Português
  'Esta es una explicación del silogismo', // Espanhol
];

final List<String> deductionExplanationTranslations_SH_Explanation = [
  'هذا شرح للاستنتاج', // Árabe
  '这是演绎的解释', // Mandarim
  'Dies ist eine Erklärung der Deduktion', // Alemão
  'This is an explanation of the Deduction', // Inglês
  'Ceci est une explication de la déduction', // Francês
  'यह अनुमान की व्याख्या है', // Hindi
  'これは推論の説明です', // Japonês
  'Esta é uma explicação da Dedução', // Português
  'Esta es una explicación de la deducción', // Espanhol
];

final List<String> tapOnEachItemForExplanationTranslations = [
  'اضغط على كل عنصر للحصول على تفسير', // Árabe
  '点击每个项目以获取解释', // Mandarim
  'Tippe auf jedes Element für eine Erklärung', // Alemão
  'Tap on each item for explanation', // Inglês
  'Appuyez sur chaque élément pour une explication', // Francês
  'प्रत्येक आइटम पर टैप करें ताकि व्याख्या मिल सके', // Hindi
  '各アイテムをタップして説明を表示', // Japonês
  'Toque em cada item para obter uma explicação', // Português
  'Toca en cada elemento para obtener una explicación', // Espanhol
];

final List<String> closeTranslations = [
  'إغلاق', // Árabe
  '关闭', // Mandarim
  'Schließen', // Alemão
  'Close', // Inglês
  'Fermer', // Francês
  'बंद करें', // Hindi
  '閉じる', // Japonês
  'Fechar', // Português
  'Cerrar', // Espanhol
];

List<String> incorrectTranslations = [
  'غير صحيح', // Árabe
  '错误', // Mandarim
  'Falsch', // Alemão
  'Incorrect', // Inglês
  'Incorrect', // Francês
  'गलत', // Hindi
  '間違い', // Japonês
  'Incorreto', // Português
  'Incorrecto' // Espanhol
];

List<String> formalTermsTranslations = [
  'الشروط الرسمية', // Árabe
  '正式条款', // Mandarim
  'Formale Bedingungen', // Alemão
  'Formal terms', // Inglês
  'Termes formels', // Francês
  'औपचारिक शर्तें', // Hindi
  '正式な条件', // Japonês
  'Termos formais', // Português
  'Términos formales' // Espanhol
];

List<String> truthTableTranslations = [
  ' جدول الحقيقة', // Árabe
  ' 真值表.', // Mandarim
  ' Wahrheitstabelle.', // Alemão
  ' Truth table.', // Inglês
  ' Tableau de vérité.', // Francês
  ' सत्य तालिका.', // Hindi
  ' 真理値表.', // Japonês
  ' Tabela verdade.', // Português
  ' Tabla de verdad.' // Espanhol
];

List<String> formallyRepresentedTranslations = [
  'تم تمثيله رسمياً  ', // Árabe
  ' 正式表示 ', // Mandarim
  ' Formal dargestellt ', // Alemão
  ' Formally represented ', // Inglês
  ' Représenté formellement ', // Francês
  ' औपचारिक रूप से प्रस्तुत किया गया ', // Hindi
  ' 正式に表現された', // Japonês
  ' Representada formalmente ', // Português
  ' Representado formalmente ' // Espanhol
];

List<String> followedByATranslations = [
  'يليه ', // Árabe
  ' 后跟一个 ', // Mandarim
  ' gefolgt von einem ', // Alemão
  ' followed by a ', // Inglês
  ' suivi de ', // Francês
  ' के बाद एक ', // Hindi
  ' の後に ', // Japonês
  ' seguido por uma ', // Português
  ' seguido de ' // Espanhol
];

List<String> theSymbolsTranslations = [
  'الرموز', // Árabe
  '符号', // Mandarim
  'Die Symbole', // Alemão
  'The symbols', // Inglês
  'Les symboles', // Francês
  'प्रतीक', // Hindi
  '記号', // Japonês
  'Os símbolos', // Português
  'Los símbolos' // Espanhol
];
