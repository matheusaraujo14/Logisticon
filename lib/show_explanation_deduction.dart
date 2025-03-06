import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_test/truth_table/truth_table_show.dart';
import 'package:new_test/font_size.dart';
import 'package:provider/provider.dart';
import 'global_language.dart';

void showTestDeduction(
  BuildContext context, {
  required ValueNotifier<List<dynamic>> premises,
  required ValueNotifier<List<String>> conclusions,
  required ValueNotifier<List<String>> incorrectConclusions,
  required ValueNotifier<List<int>> selectedCorrectOptions,
  required ValueNotifier<List<int>> selectedIncorrectOptions,
  required ValueNotifier<List<int>> selectedOptionsInOrder,
  required String sylogismType,
}) {
  final List<String> explanationOfSyllogismTypeTranslations = [
    'شرح $sylogismType', // Árabe
    '$sylogismType 说明', // Mandarim
    'Erklärung von $sylogismType', // Alemão
    'Explanation of $sylogismType', // Inglês
    'Explication de $sylogismType', // Francês
    '$sylogismType की व्याख्या', // Hindi
    '$sylogismType の説明', // Japonês
    'Explicação de $sylogismType', // Português
    'Explicación de $sylogismType', // Espanhol
  ];
  FontSizes fontSizes = FontSizes(context);
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  ScrollController scrollController = ScrollController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context)
          .colorScheme
          .tertiaryContainer, // Cor de fundo lilás claro
      contentPadding: screenWidth > screenHeight
          ? const EdgeInsets.all(30)
          : const EdgeInsets.all(15),
      content: SizedBox(
        width: 1000,
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Consumer<LanguageProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        explanationOfSyllogismTypeTranslations[
                            provider.currentLanguageIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth > screenHeight
                              ? fontSizes.large
                              : fontSizes.small,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Container para Premises sem borda
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ValueListenableBuilder<List<dynamic>>(
                    valueListenable: premises,
                    builder: (context, premisesValue, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: premisesValue.isEmpty
                          ? [const Text("No Premises available.")]
                          : premisesValue
                              .map((item) => SelectableText(
                                    "• ${item.toString()}",
                                    style: TextStyle(
                                        fontSize: fontSizes.extraSmall),
                                  ))
                              .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Lista combinada de Conclusões sem borda
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<LanguageProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          tapOnEachItemForExplanationTranslations[
                              provider.currentLanguageIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth > screenHeight
                                ? fontSizes.medium
                                : fontSizes.small,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    // Container sem borda
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: conclusions,
                        builder: (context, conclusionsValue, _) =>
                            ValueListenableBuilder<List<int>>(
                          valueListenable: selectedCorrectOptions,
                          builder: (context, correctIndices, _) =>
                              ValueListenableBuilder<List<String>>(
                            valueListenable: incorrectConclusions,
                            builder: (context, incorrectConclusionsValue, _) =>
                                ValueListenableBuilder<List<int>>(
                              valueListenable: selectedIncorrectOptions,
                              builder: (context, incorrectIndices, _) =>
                                  ValueListenableBuilder<List<int>>(
                                valueListenable: selectedOptionsInOrder,
                                builder: (context, orderedIndices, _) {
                                  // Combine os valores e índices
                                  if (orderedIndices.isEmpty ||
                                      correctIndices.isEmpty ||
                                      incorrectIndices.isEmpty) {
                                    if (kDebugMode) {
                                      print("vectors are empty");
                                    }
                                  }

                                  final combinedList = [
                                    ...conclusionsValue
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int correctIndex =
                                          entry.key < correctIndices.length
                                              ? correctIndices[entry.key]
                                              : 0;
                                      return {
                                        "text": entry.value,
                                        "index": correctIndex
                                      };
                                    }),
                                    ...incorrectConclusionsValue
                                        .asMap()
                                        .entries
                                        .map(
                                      (entry) {
                                        int incorrectIndex =
                                            entry.key < incorrectIndices.length
                                                ? incorrectIndices[entry.key]
                                                : 0;
                                        return {
                                          "text": entry.value,
                                          "index": incorrectIndex
                                        };
                                      },
                                    ),
                                  ];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: combinedList
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int displayNumber = entry.key + 1;
                                      String text =
                                          entry.value["text"] as String;
                                      int originalIndex =
                                          entry.value["index"] as int;
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Chama a função diretamente
                                              callShowSingleDeductionTruthTable(
                                                  context,
                                                  sylogismType,
                                                  originalIndex);
                                            },
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors
                                                      .blue, // Cor azul forte
                                                ),
                                                child: Text(
                                                  "$displayNumber",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Chama a função diretamente
                                                  callShowSingleDeductionTruthTable(
                                                      context,
                                                      sylogismType,
                                                      originalIndex);
                                                },
                                                child: SelectableText(
                                                  text,
                                                  onTap: () {
                                                    callShowSingleDeductionTruthTable(
                                                        context,
                                                        sylogismType,
                                                        originalIndex);
                                                  },
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenWidth >
                                                            screenHeight
                                                        ? fontSizes
                                                            .extraExtraSmall
                                                        : fontSizes.extraSmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Consumer<LanguageProvider>(
            builder: (context, provider, child) {
              return Text(
                closeTranslations[provider.currentLanguageIndex],
                style: TextStyle(
                  fontSize: fontSizes.extraExtraSmall,
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

void callShowSingleDeductionTruthTable(
    BuildContext context, String deductionName, int deductionNumber) {
  // Chama a função ShowSingleDeductionTruthTable com os parâmetros fornecidos

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: ShowSingleDeductionTruthTable(
              deductionName: deductionName,
              deductionNumber: deductionNumber,
              fontSizeExplanation: FontSizes(context).extraExtraSmall,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Consumer<LanguageProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      closeTranslations[provider.currentLanguageIndex],
                      style: TextStyle(
                        fontSize: FontSizes(context).extraExtraSmall,
                      ),
                    );
                  },
                ),
              ),
            ],
          ));
}
