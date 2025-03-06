import 'package:flutter/material.dart';
import 'package:new_test/explain_syllogism.dart';
import 'package:new_test/font_size.dart';
import 'package:new_test/truth_table/truth_table.dart' as tt;
import 'package:new_test/truth_table/truth_table_show.dart';
import 'package:provider/provider.dart';
import 'global_language.dart';

String toTitleCase(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text.split(' ').map((word) {
    if (word.isEmpty) {
      return word;
    }
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

void showExplanation(
    BuildContext context,
    String syllogismType,
    bool isSyllogism,
    List<int> selectedCorrectOptions,
    List<int> selectedIncorrectOptions) {
  FontSizes fontSizes = FontSizes(context);
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(30),
      content: SizedBox(
        width: 1000,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    final int currentIndex =
                        languageProvider.currentLanguageIndex;

                    return Text(
                      syllogismType.contains('Deduction')
                          ? deductionExplanationTranslations_SH_Explanation[
                              currentIndex]
                          : '${syllogismExplanationTranslations_SH_Explanation[currentIndex]} $syllogismType',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth > screenHeight
                            ? fontSizes.large
                            : fontSizes.medium,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              selectableSyllogismText(context, syllogismType),
              const SizedBox(height: 10),
              Image.asset(
                'assets/Diagramas/$syllogismType.png',
                height: 400,
                width: 500,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
