import 'dart:io';

import 'package:new_test/truth_table/gen_func_chat_gpt.dart';
import 'package:new_test/truth_table/instance_deduction.dart';
import 'package:flutter/material.dart';

// stateful widget named GenerateFunctionForChatGPT
// with a MaterialApp and a Scaffold that shows a text field
// for the user to enter a file name and a button to generate
// a file with the function for the chatGPT

class GenerateFunctionForChatGPT extends StatefulWidget {
  const GenerateFunctionForChatGPT({super.key});

  @override
  GenerateFunctionForChatGPTState createState() =>
      GenerateFunctionForChatGPTState();
}

class GenerateFunctionForChatGPTState
    extends State<GenerateFunctionForChatGPT> {
  final TextEditingController _controller = TextEditingController();
  String _fileName = '';

  void _generateFile() {
    _fileName = _controller.text;
    final file = File(_fileName);
    file.writeAsString(generateFunctionForChatGPT(deductionList));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _controller.text =
        r'Z:\current-projects\newprojects\logisticon_chats_dart\lib\gpfd.dart';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate function for chatGPT'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter file name',
            ),
          ),

          /// 20 spaces
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generateFile,
            child: const Text('Generate file'),
          ),
        ],
      ),
    );
  }
}

class GenerateTextForDeductions extends StatefulWidget {
  const GenerateTextForDeductions({super.key});

  @override
  GenerateTextForDeductionsState createState() =>
      GenerateTextForDeductionsState();
}

class GenerateTextForDeductionsState extends State<GenerateTextForDeductions> {
  final TextEditingController _controller = TextEditingController();
  String _fileName = '';

  void _generateFile() {
    _fileName = _controller.text;
    final file = File(_fileName);
    file.writeAsString(generateTextDeductions(deductionList));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _controller.text =
        r'C:\Dropbox\24-1\walter - pensamento critico - grupo de jogos\deductions-descriptions.txt';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generate text for deductions'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter file name',
                ),
              ),

              /// 20 spaces
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateFile,
                child: const Text('Generate file'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
