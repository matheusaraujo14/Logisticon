import 'package:flutter/material.dart';
import 'package:new_test/show_explanation.dart';
import 'package:new_test/truth_table/lang_code_name.dart';
import 'package:new_test/main.dart';
import 'package:new_test/font_size.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flag/flag.dart';
import 'global_language.dart'; // Import GlobalSettings
import 'package:provider/provider.dart';

class ChooseLanguage extends StatefulWidget {
  final List<String> languages;

  ChooseLanguage({required this.languages});

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

int? chosenLanguageIndexGlobal = 3;
bool changedLanguage = false;

// ignore: must_be_immutable
class _ChooseLanguageState extends State<ChooseLanguage> {
  Future<int>? chosenIndexFuture;

  // chosenIndexFuture = choosenIndex

  void initState() {
    super.initState();
    // Inicialize chosenIndexFuture com o valor global.
    chosenIndexFuture = Future.value(chosenLanguageIndexGlobal);
  }

  Future<int> chooseLanguage() async {
    int? chosenIndex = await showModalBottomSheet<int>(
      backgroundColor: Colors.lightBlue,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: widget.languages.length,
          itemBuilder: (context, index) {
            String? twoLetterCode =
                threeLetterCodeToCountryCode(widget.languages[index]);
            return ListTile(
              shape: index == 0
                  ? const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    )
                  : null,
              hoverColor: Colors.lightBlue.shade700,
              title: Row(
                children: [
                  Flag.fromCode(
                    FlagsCode.values
                        .firstWhere((code) => code.name == twoLetterCode),
                    height: 30,
                    width: 50,
                    borderRadius: 10,
                  ),
                  const SizedBox(width: 8),
                  Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSizes(context).extraSmall,
                        fontWeight: FontWeight.w600,
                      ),
                      toTitleCase(
                          codeToLanguageName(widget.languages[index])!)),
                ],
              ),
              onTap: () {
                setState(() {
                  chosenIndexFuture = Future.value(index);
                  chosenLanguageIndexGlobal = index; // Atualiza o idioma global
                });
                Provider.of<LanguageProvider>(context, listen: false)
                    .setLanguage(index);
                Navigator.pop(context, index);
              },
            );
          },
        );
      },
    );

    String getTwoLetterCode() {
      return threeLetterCodeToCountryCode(widget.languages[chosenIndex!])!;
    }

    if (chosenIndex == null) {
      changedLanguage = false;
      return chosenLanguageIndexGlobal!;
    }
    changedLanguage = true;
    chosenLanguageIndexGlobal = chosenIndex;

    Future<Map<String, dynamic>> tempLib = readJson(chosenIndex);
    mapFileToContents = await tempLib;

    return chosenIndex;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<int>(
      future: chosenIndexFuture,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          return screenHeight > screenWidth
              ? SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                    ),
                    onPressed: () {
                      setState(() {
                        chosenIndexFuture = chooseLanguage();
                      });
                    },
                    child: Text(
                      toTitleCase(codeToLanguageName(
                          widget.languages[snapshot.data ?? 0])!),
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Flag.fromCode(
                        FlagsCode.values.firstWhere((code) =>
                            code.name ==
                            threeLetterCodeToCountryCode(
                                widget.languages[snapshot.data ?? 0])),
                        height: 30,
                        width: 50,
                        borderRadius: 10,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade800,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          shadowColor: Colors.black,
                          elevation: 10,
                        ),
                        onPressed: () {
                          setState(() {
                            chosenIndexFuture = chooseLanguage();
                          });
                        },
                        child: Text(
                          toTitleCase(codeToLanguageName(
                              widget.languages[snapshot.data ?? 0])!),
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Flag.fromCode(
                        FlagsCode.values.firstWhere((code) =>
                            code.name ==
                            threeLetterCodeToCountryCode(
                                widget.languages[snapshot.data ?? 0])),
                        height: 30,
                        width: 50,
                        borderRadius: 10,
                      ),
                    ),
                  ],
                );
        }
      },
    );
  }
}
