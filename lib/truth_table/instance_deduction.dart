import 'package:new_test/truth_table/util.dart';
import 'package:flutter/material.dart';

class InstanceDeductionConclusion {
  /// deduction name
  final String name;

  /// list of premises in the language of logic using
  /// operators ->, v, ^, ~, parentheses, and variables that are single
  /// upper-case letters
  final List<String> premises;

  /// conclusion in the language of logic
  final String conclusion;

  /// true if 'conclusion' is a correct conclusion from the premises
  bool isCorrect;

  /// list of colors for the squares of the truth table
  List<
      (
        Color color,
        (
          int lineTopLeft,
          int columnTopLeft,
          int lineBottomRight,
          int columnBottomRight
        )
      )> colorSquareList = [];

  List<String> explanation;

  InstanceDeductionConclusion(
      {required this.name,
      required this.premises,
      required this.conclusion,
      this.isCorrect = true,
      this.colorSquareList = const [],
      this.explanation = const []}) {
    var oldIsCorrect = isCorrect;
    isCorrect = true;
    for (var elem in colorSquareList) {
      if (elem.$1 == colorLinesAllPremisesTrueIncorrect) {
        isCorrect = false;
        break;
      }
    }
    if (oldIsCorrect != isCorrect) {
      print('Deduction name = $name, conclusion = $conclusion');
      throw 'isCorrect = $isCorrect';
    }

    explanation = isCorrect
        ? listremoveExtraSpaces(explanationForCorrectDeductionTranslations)
        : listremoveExtraSpaces(explanationForIncorrectDeductionTranslations);
  }
}

const colorLinesAllPremisesTrueCorrect = Color.fromARGB(255, 227, 249, 232);
const colorLinesAllPremisesTrueIncorrect = Color.fromARGB(255, 255, 115, 105);

/*const explanationForCorrectDeduction =
    '''The first line of the truth table shows the premises in yellow and 
    the conclusion in light gray. If there is a line in which all the premises
    are true, the cells corresponding to the premises are marked in light orange. 
    If, in this line, the conclusion is also true,
    the conclusion cell is marked in green. Otherwise,
    the conclusion cell  is marked in red. This conclusion is correct because,
    whenever the premises are true (light orange), the conclusion is also true (green).
        ''';
*/

final List<String> explanationForCorrectDeductionTranslations = [
  'السطر الأول من جدول الحقيقة يظهر المقدمات باللون الأصفر والاستنتاج باللون الرمادي الفاتح. إذا وُجد سطر تكون فيه كل المقدمات صحيحة، يتم تمييز الخلايا المقابلة للمقدمات باللون البرتقالي الفاتح. إذا كان الاستنتاج صحيحاً في هذا السطر، يتم تمييز خلية الاستنتاج باللون الأخضر. وإلا، يتم تمييز خلية الاستنتاج باللون الأحمر. هذا الاستنتاج صحيح لأنه كلما كانت المقدمات صحيحة (باللون البرتقالي الفاتح)، يكون الاستنتاج صحيحاً أيضاً (باللون الأخضر).', // Árabe
  '真值表的第一行用黄色显示前提，用浅灰色显示结论。如果存在一行中所有前提都为真，则与前提对应的单元格会标记为浅橙色。如果在这一行中，结论也为真，则结论的单元格会标记为绿色。否则，结论的单元格会标记为红色。这个结论是正确的，因为每当前提为真（浅橙色），结论也为真（绿色）。', // Mandarim
  'Die erste Zeile der Wahrheitstabelle zeigt die Prämissen in Gelb und die Konklusion in Hellgrau. Wenn es eine Zeile gibt, in der alle Prämissen wahr sind, werden die Zellen, die den Prämissen entsprechen, in Hellorange markiert. Wenn in dieser Zeile auch die Konklusion wahr ist, wird die Zelle der Konklusion grün markiert. Andernfalls wird die Zelle der Konklusion rot markiert. Diese Schlussfolgerung ist korrekt, da immer, wenn die Prämissen wahr sind (hellorange), auch die Konklusion wahr ist (grün).', // Alemão
  'The first line of the truth table shows the premises in yellow and the conclusion in light gray. If there is a line in which all the premises are true, the cells corresponding to the premises are marked in light orange. If, in this line, the conclusion is also true, the conclusion cell is marked in green. Otherwise, the conclusion cell is marked in red. This conclusion is correct because whenever the premises are true (light orange), the conclusion is also true (green).', // Inglês
  'La première ligne de la table de vérité montre les prémisses en jaune et la conclusion en gris clair. S’il existe une ligne où toutes les prémisses sont vraies, les cases correspondant aux prémisses sont marquées en orange clair. Si, dans cette ligne, la conclusion est également vraie, la case de la conclusion est marquée en vert. Sinon, la case de la conclusion est marquée en rouge. Cette conclusion est correcte car, chaque fois que les prémisses sont vraies (orange clair), la conclusion l’est aussi (vert).', // Francês
  'ट्रुथ टेबल की पहली पंक्ति में पीले रंग में प्रस्ताव और हल्के धूसर रंग में निष्कर्ष दिखाए जाते हैं। यदि ऐसी कोई पंक्ति होती है जिसमें सभी प्रस्ताव सत्य हों, तो प्रस्तावों से संबंधित सेल्स को हल्के नारंगी रंग में चिह्नित किया जाता है। यदि उस पंक्ति में निष्कर्ष भी सत्य होता है, तो निष्कर्ष वाले सेल को हरे रंग में चिह्नित किया जाता है। अन्यथा, निष्कर्ष वाले सेल को लाल रंग में चिह्नित किया जाता है। यह निष्कर्ष इसलिए सही है क्योंकि जब भी प्रस्ताव सत्य होते हैं (हल्का नारंगी), निष्कर्ष भी सत्य होता है (हरा).', // Hindi
  '真理値表の最初の行は、前提が黄色で、結論が薄い灰色で示されています。もしすべての前提が真となる行がある場合、その行の前提に対応するセルは薄いオレンジ色でマークされます。その行で結論も真であれば、結論のセルは緑色でマークされます。そうでない場合、結論のセルは赤色でマークされます。この結論は、前提が真（薄いオレンジ色）であるとき、結論も真（緑色）であるため正しいとされています。', // Japonês
  'A primeira linha da tabela verdade mostra as premissas em amarelo e a conclusão em cinza claro. Se houver uma linha em que todas as premissas são verdadeiras, as células correspondentes às premissas são marcadas em laranja claro. Se, nessa linha, a conclusão também for verdadeira, a célula da conclusão é marcada em verde. Caso contrário, a célula da conclusão é marcada em vermelho. Essa conclusão está correta porque, sempre que as premissas são verdadeiras (laranja claro), a conclusão também é verdadeira (verde).', // Português
  'La primera línea de la tabla de verdad muestra las premisas en amarillo y la conclusión en gris claro. Si hay una línea en la que todas las premisas son verdaderas, las celdas correspondientes a las premisas se marcan en naranja claro. Si, en esa línea, la conclusión también es verdadera, la celda de la conclusión se marca en verde. De lo contrario, la celda de la conclusión se marca en rojo. Esta conclusión es correcta porque, siempre que las premisas sean verdaderas (naranja claro), la conclusión también es verdadera (verde).', // Espanhol
];

/*const oldExplanationForCorrectDeduction =
    'In the first line of the truth table, the formulas in yellow are the premises of the deduction '
    'and the formula in light gray is the conclusion. '
    'All cells in which all the premises are true are marked in light orange (if any). '
    'In the line of each light orange cell, the conclusion is marked in green because '
    'it is also true. '
    'Therefore, the conclusion is correct  because whenever the premises are true (light orange), '
    'the conclusion is also true (green).';
*/
final List<String> oldExplanationForCorrectDeductionTranslations = [
  'في السطر الأول من جدول الحقيقة، الصيغ باللون الأصفر هي مقدمات الاستنتاج والصيغة باللون الرمادي الفاتح هي النتيجة. جميع الخلايا التي تكون فيها جميع المقدمات صحيحة يتم تمييزها باللون البرتقالي الفاتح (إن وجدت). في السطر الذي تحتوي فيه الخلية البرتقالية الفاتحة، يتم تمييز النتيجة باللون الأخضر لأنها صحيحة أيضًا. لذلك، الاستنتاج صحيح لأنه كلما كانت المقدمات صحيحة (برتقالي فاتح)، تكون النتيجة صحيحة أيضًا (أخضر).', // Árabe
  '在真值表的第一行，黄色的公式是推理的前提，浅灰色的公式是结论。所有前提都为真的单元格（如果有）会被标记为浅橙色。在包含浅橙色单元格的行中，结论被标记为绿色，因为它也为真。因此，该结论是正确的，因为每当前提为真（浅橙色），结论也为真（绿色）。', // Mandarim
  'In der ersten Zeile der Wahrheitstabelle sind die Formeln in Gelb die Prämissen der Deduktion und die Formel in Hellgrau ist die Konklusion. Alle Zellen, in denen alle Prämissen wahr sind, werden in Hellorange markiert (falls vorhanden). In der Zeile mit einer hellorangen Zelle wird die Konklusion grün markiert, da sie ebenfalls wahr ist. Daher ist die Schlussfolgerung korrekt, da immer, wenn die Prämissen wahr sind (hellorange), die Konklusion ebenfalls wahr ist (grün).', // Alemão
  'In the first line of the truth table, the formulas in yellow are the premises of the deduction and the formula in light gray is the conclusion. All cells in which all the premises are true are marked in light orange (if any). In the line of each light orange cell, the conclusion is marked in green because it is also true. Therefore, the conclusion is correct because whenever the premises are true (light orange), the conclusion is also true (green).', // Inglês
  'Dans la première ligne de la table de vérité, les formules en jaune sont les prémisses de la déduction et la formule en gris clair est la conclusion. Toutes les cellules dans lesquelles toutes les prémisses sont vraies sont marquées en orange clair (si elles existent). Dans la ligne contenant une cellule orange clair, la conclusion est marquée en vert car elle est également vraie. Par conséquent, la conclusion est correcte, car chaque fois que les prémisses sont vraies (orange clair), la conclusion est également vraie (vert).', // Francês
  'सत्य सारणी की पहली पंक्ति में, पीले रंग के सूत्र अनुमान के पूर्वधारणाएं हैं और हल्के धूसर रंग का सूत्र निष्कर्ष है। सभी कोशिकाएं, जिनमें सभी पूर्वधारणाएं सत्य हैं, हल्के नारंगी रंग में चिह्नित की जाती हैं (यदि कोई हो)। प्रत्येक हल्के नारंगी कोशिका वाली पंक्ति में, निष्कर्ष को हरे रंग में चिह्नित किया जाता है क्योंकि वह भी सत्य है। इसलिए, निष्कर्ष सही है क्योंकि जब भी पूर्वधारणाएं सत्य होती हैं (हल्का नारंगी), निष्कर्ष भी सत्य होता है (हरा)।', // Hindi
  '真理値表の最初の行では、黄色の式が推論の前提であり、薄い灰色の式が結論です。すべての前提が真となるセル（もしあれば）は薄いオレンジ色でマークされます。各薄いオレンジ色のセルがある行では、結論は緑色でマークされます。なぜなら、それも真だからです。したがって、この結論は正しいです。なぜなら、前提が真（薄いオレンジ色）であるとき、結論も真（緑色）だからです。', // Japonês
  'Na primeira linha da tabela verdade, as fórmulas em amarelo são as premissas da dedução e a fórmula em cinza claro é a conclusão. Todas as células em que todas as premissas são verdadeiras são marcadas em laranja claro (se houver). Na linha de cada célula laranja clara, a conclusão é marcada em verde porque também é verdadeira. Portanto, a conclusão está correta, pois sempre que as premissas são verdadeiras (laranja claro), a conclusão também é verdadeira (verde).', // Português
  'En la primera línea de la tabla de verdad, las fórmulas en amarillo son las premisas de la deducción y la fórmula en gris claro es la conclusión. Todas las celdas en las que todas las premisas son verdaderas se marcan en naranja claro (si las hay). En la línea de cada celda naranja claro, la conclusión se marca en verde porque también es verdadera. Por lo tanto, la conclusión es correcta porque, siempre que las premisas sean verdaderas (naranja claro), la conclusión también es verdadera (verde).', // Espanhol
];

const oldExplanationForIncorrectDeduction =
    'In the first line of the truth table, the formulas in yellow are the premises of the deduction '
    'and the formula in light gray is the conclusion. '
    'All cells in which all the premises are true are marked in light orange (if any). '
    'There is at least a line in which all the premises are true (light orange cells) '
    'and the conclusion is false (red cells). '
    'Therefore, the conclusion is incorrect because in at least one line, the premises are true (light orange) '
    'but the conclusion is false (red).';

/*const explanationForIncorrectDeduction =
    '''The first line of the truth table shows the premises in yellow and 
    the conclusion in light gray. If there is a line in which all the premises
    are true, the cells corresponding to the premises are marked in light orange. 
    If, in this line, the conclusion is also true,
    the conclusion cell is marked in green. Otherwise,
    the conclusion cell  is marked in red. This conclusion is INCORRECT because
    there is at least one line in which the premises are true (light orange) and
    the conclusion is false (red cell).
        ''';
        */

final List<String> explanationForIncorrectDeductionTranslations = [
  'في السطر الأول من جدول الحقيقة، يتم عرض المقدمات باللون الأصفر والنتيجة باللون الرمادي الفاتح. إذا كانت هناك سطر تكون فيه جميع المقدمات صحيحة، يتم تمييز الخلايا المقابلة للمقدمات باللون البرتقالي الفاتح. إذا كانت النتيجة أيضًا صحيحة في هذا السطر، يتم تمييز خلية النتيجة باللون الأخضر. خلاف ذلك، يتم تمييز خلية النتيجة باللون الأحمر. هذا الاستنتاج غير صحيح لأنه يوجد على الأقل سطر واحد تكون فيه المقدمات صحيحة (برتقالي فاتح) والنتيجة خاطئة (خلية حمراء).', // Árabe
  '在真值表的第一行，前提用黄色表示，结论用浅灰色表示。如果存在一行，所有前提都为真，则相应的单元格将被标记为浅橙色。如果在这一行中，结论也为真，则结论单元格标记为绿色。否则，结论单元格将标记为红色。这个结论是不正确的，因为至少有一行，前提为真（浅橙色），但结论为假（红色单元格）。', // Mandarim
  'In der ersten Zeile der Wahrheitstabelle sind die Prämissen gelb markiert und die Konklusion hellgrau. Falls es eine Zeile gibt, in der alle Prämissen wahr sind, werden die entsprechenden Zellen in Hellorange markiert. Ist in dieser Zeile auch die Konklusion wahr, wird die Konklusionszelle grün markiert. Andernfalls wird die Konklusionszelle rot markiert. Diese Schlussfolgerung ist falsch, weil es mindestens eine Zeile gibt, in der die Prämissen wahr sind (hellorange) und die Konklusion falsch ist (rote Zelle).', // Alemão
  'The first line of the truth table shows the premises in yellow and the conclusion in light gray. If there is a line in which all the premises are true, the cells corresponding to the premises are marked in light orange. If, in this line, the conclusion is also true, the conclusion cell is marked in green. Otherwise, the conclusion cell is marked in red. This conclusion is INCORRECT because there is at least one line in which the premises are true (light orange) and the conclusion is false (red cell).', // Inglês
  'La première ligne de la table de vérité montre les prémisses en jaune et la conclusion en gris clair. S’il existe une ligne où toutes les prémisses sont vraies, les cellules correspondantes sont marquées en orange clair. Si, dans cette ligne, la conclusion est également vraie, la cellule de conclusion est marquée en vert. Sinon, la cellule de conclusion est marquée en rouge. Cette conclusion est INCORRECTE car il existe au moins une ligne où les prémisses sont vraies (orange clair) et la conclusion est fausse (cellule rouge).', // Francês
  'सत्य सारणी की पहली पंक्ति में, पूर्वधारणाएं पीले रंग में और निष्कर्ष हल्के धूसर रंग में होते हैं। यदि कोई पंक्ति है जहां सभी पूर्वधारणाएं सत्य हैं, तो संबंधित कोशिकाएं हल्के नारंगी रंग में चिह्नित की जाती हैं। यदि इस पंक्ति में निष्कर्ष भी सत्य है, तो निष्कर्ष कोशिका हरे रंग में चिह्नित की जाती है। अन्यथा, निष्कर्ष कोशिका को लाल रंग में चिह्नित किया जाता है। यह निष्कर्ष गलत है क्योंकि कम से कम एक पंक्ति है जहां पूर्वधारणाएं सत्य हैं (हल्का नारंगी) और निष्कर्ष गलत है (लाल कोशिका)।', // Hindi
  '真理値表の最初の行では、前提が黄色で表示され、結論が薄い灰色で表示されます。すべての前提が真である行が存在する場合、対応するセルは薄いオレンジ色でマークされます。その行で結論も真であれば、結論のセルは緑でマークされます。そうでない場合、結論のセルは赤でマークされます。この結論は間違っています。なぜなら、少なくとも一つの行において、前提が真（薄いオレンジ色）であるのに結論が偽（赤いセル）であるからです。', // Japonês
  'A primeira linha da tabela verdade mostra as premissas em amarelo e a conclusão em cinza claro. Se houver uma linha em que todas as premissas são verdadeiras, as células correspondentes às premissas são marcadas em laranja claro. Se, nessa linha, a conclusão também for verdadeira, a célula da conclusão será marcada em verde. Caso contrário, a célula da conclusão será marcada em vermelho. Essa conclusão está INCORRETA porque existe pelo menos uma linha em que as premissas são verdadeiras (laranja claro) e a conclusão é falsa (célula vermelha).', // Português
  'La primera línea de la tabla de verdad muestra las premisas en amarillo y la conclusión en gris claro. Si hay una línea en la que todas las premisas son verdaderas, las celdas correspondientes a las premisas se marcan en naranja claro. Si, en esa línea, la conclusión también es verdadera, la celda de la conclusión se marca en verde. De lo contrario, la celda de la conclusión se marca en rojo. Esta conclusión es INCORRECTA porque hay al menos una línea en la que las premisas son verdaderas (naranja claro) y la conclusión es falsa (celda roja).', // Espanhol
];

List<InstanceDeductionConclusion> deductionList = [
  InstanceDeductionConclusion(
    name: 'Implication',
    premises: ['A -> B'],
    conclusion: '~B -> ~A',
    isCorrect: true,
    colorSquareList: [
      (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
      (colorLinesAllPremisesTrueCorrect, (3, 3, 4, 3)),
    ],
    explanation:
        explanationForCorrectDeductionTranslations, // Dependendo do idioma selecionado
  ),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 0, 1, 0)),
        (colorLinesAllPremisesTrueIncorrect, (3, 0, 4, 0))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 3, 4, 3)),
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 1, 1, 1)),
        (colorLinesAllPremisesTrueCorrect, (3, 1, 3, 1)),
        (colorLinesAllPremisesTrueIncorrect, (4, 1, 4, 1))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3)),
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3))
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueCorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueIncorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Implication',
      premises: ['A -> B'],
      conclusion: '~A -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3)),
        (colorLinesAllPremisesTrueIncorrect, (3, 3, 3, 3)),
        (colorLinesAllPremisesTrueCorrect, (4, 3, 4, 3))
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: 'B',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 1, 1, 1)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: 'B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~A -> ~B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (1, 3, 1, 3))],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponens',
      premises: ['A -> B', 'A'],
      conclusion: '~B', //indicadores da linha nao aparecem
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 3, 1, 3)),
      ],
      explanation: explanationForCorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~A',
      isCorrect: true, //indicadores das linhas nao aparecem
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'B -> A', //indicadores das linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~A -> ~B', //indicadores das linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (4, 4, 4, 4)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: '~B -> A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 0, 4, 0))],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollens',
      premises: ['A -> B', '~B'],
      conclusion: 'A ^ B', //indicadores das linhas nao aparecem
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (4, 4, 4, 4))],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 1, 3, 1))],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 4, 3, 4))],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'A -> B',
      isCorrect: true,
      colorSquareList: [(colorLinesAllPremisesTrueCorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: '~B',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Tollendo Ponens',
      premises: ['(A v B) ^ (~A v ~B)', '~A'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [(colorLinesAllPremisesTrueIncorrect, (3, 4, 3, 4))],
      explanation: explanationForCorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~B',
      isCorrect: true, //linhas nao aparecem
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~A -> B', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: 'B -> ~A', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: 'A -> ~B', //linhas nao aparecem
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Modus Ponendo Tollens',
      premises: ['(A v B) ^ (~A v ~B)', 'A'],
      conclusion: '~B -> ~A', //linhas nao aparecem
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (2, 3, 2, 3)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 2, 1, 2)),
        (colorLinesAllPremisesTrueCorrect, (3, 2, 3, 2)),
        (colorLinesAllPremisesTrueCorrect, (5, 2, 5, 2))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(A v B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~C -> (~A ^ ~B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(A ^ B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C -> (A v B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'A -> (B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~A -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '~C -> (A ^ B)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueCorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: 'C -> (A ^ B)',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueIncorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueIncorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Constructive Dilemma',
      premises: ['A -> C', 'B -> C', 'A v B'],
      conclusion: '(C v A) -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 6, 1, 6)),
        (colorLinesAllPremisesTrueIncorrect, (3, 6, 3, 6)),
        (colorLinesAllPremisesTrueCorrect, (5, 6, 5, 6))
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~(B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'A -> (B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),

  // . not A implies not B or not C
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '~A -> (~B v ~C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  // B and C implies A
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'B ^ C -> A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),

  // . B or C implies A
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '(B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (6, 6, 7, 6)),
        (colorLinesAllPremisesTrueCorrect, (8, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (6, 6, 6, 6)),
        (colorLinesAllPremisesTrueCorrect, (7, 6, 8, 6)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Destructive Dilemma',
      premises: ['A -> B', 'A -> C', '~B v ~C'],
      conclusion: '(B ^ ~C) v (~B ^ C)',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (6, 6, 7, 6)),
        (colorLinesAllPremisesTrueIncorrect, (8, 6, 8, 6)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v B) -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(~A ^ B) -> C^(A -> C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 0, 1, 0)),
        (colorLinesAllPremisesTrueIncorrect, (5, 0, 5, 0)),
        (colorLinesAllPremisesTrueIncorrect, (7, 0, 8, 0)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: 'C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 2, 1, 2)),
        (colorLinesAllPremisesTrueCorrect, (5, 2, 5, 2)),
        (colorLinesAllPremisesTrueCorrect, (7, 2, 7, 2)),
        (colorLinesAllPremisesTrueIncorrect, (8, 2, 8, 2)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '~B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Double Implication',
      premises: ['A -> B', 'B -> C'],
      conclusion: '(A v ~B) -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'A -> (B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'A -> (B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~B -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(~B v ~C) -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~B -> ~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '~C -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: 'C -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueCorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 1',
      premises: ['A -> B', 'A -> C'],
      conclusion: '(~B v ~A) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'A -> (~B ^ C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'A -> (~B v C)',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'B -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(B v ~C) -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'B -> ~C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~C -> B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '~B -> C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 7, 5)),
        (colorLinesAllPremisesTrueIncorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: 'C -> ~B',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(~B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 7, 5)),
        (colorLinesAllPremisesTrueCorrect, (8, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(~B v C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
        (colorLinesAllPremisesTrueIncorrect, (7, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 2',
      premises: ['A -> ~B', 'A -> C'],
      conclusion: '(B v ~A) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 8, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~B -> A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~C -> ~A',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~C -> B',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B v C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '(A ^ B) -> C',
      isCorrect: true,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForCorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueIncorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  // not B implies not A
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '~B -> ~A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),

  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'B ^ C',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueIncorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueCorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueIncorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: 'C -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations),
  InstanceDeductionConclusion(
      name: 'Deduction 3',
      premises: ['~A -> B', 'A -> C'],
      conclusion: '(B ^ C) -> A',
      isCorrect: false,
      colorSquareList: [
        (colorLinesAllPremisesTrueCorrect, (1, 5, 1, 5)),
        (colorLinesAllPremisesTrueCorrect, (3, 5, 3, 5)),
        (colorLinesAllPremisesTrueIncorrect, (5, 5, 5, 5)),
        (colorLinesAllPremisesTrueCorrect, (6, 5, 6, 5)),
      ],
      explanation: explanationForIncorrectDeductionTranslations)
];

void countNumberOfDeductions() {
  int count = 0;
  for (var deductionName in deductionNameList) {
    var subDeductionList = deductionListByName(deductionName);
    count += subDeductionList.length;
    print('deductionName: $deductionName, count: ${subDeductionList.length}');
  }
  print('count: $count');
}

const deductionNameList = [
  'Implication',
  'Modus Ponens',
  'Modus Tollens',
  'Modus Tollendo Ponens',
  'Modus Ponendo Tollens',
  'Constructive Dilemma',
  'Destructive Dilemma',
  'Double Implication',
  'Deduction 1',
  'Deduction 2',
  'Deduction 3'
];

List<InstanceDeductionConclusion> deductionListByName(String deductionName) {
  return deductionList
      .where((element) =>
          element.name.toLowerCase() == deductionName.toLowerCase())
      .toList();
}
