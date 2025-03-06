import 'package:new_test/truth_table/truth_table_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// variable widthTable and heighTable using flutter_riverpod
final widthTable = StateProvider<double>((ref) => 500);
final heightTable = StateProvider<double>((ref) => 300);
final premisesStrList = StateProvider<List<String>>((ref) => ['A', 'A -> B']);
final conclusionStr = StateProvider<String>((ref) => 'B');
final colorSquareList = StateProvider<
    List<
        (
          Color,
          (
            int lineTopLeft,
            int columnTopLeft,
            int lineBottomRight,
            int columnBottomRight
          )
        )>>((ref) => []);
final deductionName = StateProvider<String>((ref) => '');
final explanation = StateProvider<String>((ref) => '');
final isCorrect = StateProvider<bool>((ref) => false);

class EditableTableState extends ConsumerWidget {
  const EditableTableState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Editable table')),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
              width: 600,
              child: Column(
                children: [
                  Consumer(builder: (context, ref, watch) {
                    /// return a editable text field that updates the value of deductionName as a string
                    /// using the watch function to listen to the deductionName state
                    return TextField(
                      onChanged: (value) {
                        ref.read(deductionName.notifier).state = value;
                      },

                      /// put a border in this text field
                      /// and a hint text that says 'Enter deduction name'
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter deduction name'),
                    );
                  }),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: ref.watch(widthTable),
                    height: ref.watch(heightTable),
                    child: testTruthTableFormulaList(
                        ref.watch(premisesStrList), [ref.watch(conclusionStr)],
                        colorSquareList: ref.watch(colorSquareList)),
                  ),

                  /// vertical space of 10
                  const SizedBox(height: 10),
                  Text(
                    ref.watch(explanation),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),

                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            double width = double.tryParse(value) ?? 500;
                            if (width < 200) {
                              width = 200;
                            }
                            ref.read(widthTable.notifier).state = width;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Table width'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            double height = double.tryParse(value) ?? 500;
                            ref.read(heightTable.notifier).state = height;
                          },

                          /// put a border in this text field
                          /// and a hint text that says 'Enter deduction name'
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Table height'),
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// A button 'update table' that updates the table using setstate
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Update table'),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget testTruthTableFormulaList(
      List<String> premisesStrList, List<String> conclusionStrList,
      {required List<
              (
                Color,
                (
                  int lineTopLeft,
                  int columnTopLeft,
                  int lineBottomRight,
                  int columnBottomRight
                )
              )>
          colorSquareList}) {
    try {
      final t = truthTableFormulaList(
        premisesStrList,
        conclusionStrList,
        colorSquareList: colorSquareList,
      );
      return t;
    } catch (e) {
      return const Text('Error in formula');
    }
  }
}
