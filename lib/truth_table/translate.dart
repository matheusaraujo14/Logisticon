import 'dart:io';

import 'package:exponential_back_off/exponential_back_off.dart';
import 'dart:convert';
import 'lang_code_name.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String apiKey = 'put here an api key';

/// translate the sentence of directory sentenceDirectory
Future<(Directory, Map<String, dynamic>)> translateSentence(
    {required String langCode,
    required Directory sentenceDirectory,
    required String languageNameColonLangCodeList,
    double temperature = 0.4,
    int maxAttemptsBadReplay = 10,
    bool printTime = false}) async {
  String sentenceText;

  /// read the file sentenceDirectory/sentenceText.txt into sentenceText
  try {
    sentenceText = File(
            '${sentenceDirectory.path}${Platform.pathSeparator}sentenceText.txt')
        .readAsStringSync();
  } catch (e) {
    throw ExceptionMsg(
        'Cannot read file "${sentenceDirectory.path}/sentenceText.txt"');
  }

  CountTokens count = CountTokens();
  var query = [
    {
      'role': 'system',
      'content': 'You are an translator of the  English language.'
    },
    {
      'role': 'user',
      'content': '''
I will give you a list (between { and } )of (key, value) pairs composed of language names and 3-digit codes. 
The list is:
{
$languageNameColonLangCodeList
}  
Translate the sentence '$sentenceText' from english to every one of the 
other languages in the list. Give the answer as a JSON object in which 
the language codes are keys and the translated sentences are values. 
Use UTF-8 encoding. 

      '''
    }
  ];

  var queryWhenJsonIsWrong = [
    {
      'role': 'system',
      'content': 'You are an translator of the  English language.'
    },
    {
      'role': 'user',
      'content': '''
      Your reply is wrong. The answer is not in JSON. Probably the answer is 
      incomplete. In the next prompt I will ask again the same question, 
      please  correct your answer.'''
    }
  ];

  bool retryGPTCall = false;
  int maxRetryGPTCall = 30;
  int numRetryGPTCall = 0;

  Map<String, dynamic> jsonReplay = {};
  bool badReplayFromChatGPT = false;

  do {
    final currentQuery = query;
    try {
      String replay = '';
      if (printTime) {
        startStopwatch();
      }
      jsonReplay = {};
      int countAttempts = 0;
      do {
        badReplayFromChatGPT = false;
        replay =
            await gptConnect(currentQuery, count, temperature: temperature);
        try {
          try {
            jsonReplay = jsonDecode(replay); // List<String>, List<dynamic>
          } catch (e) {
            File('z:/replay.txt').writeAsStringSync(replay);
            await gptConnect(queryWhenJsonIsWrong, count,
                temperature: temperature);
            rethrow;
          }

          /// -1 because the first element is the english translation, which should
          /// not be included because it is the original sentence language
          if (jsonReplay.keys.length !=
              initiallySupportedLanguagesAppList.length - 1) {
            badReplayFromChatGPT = true;
          }
          for (var (_, langCode)
              in initiallySupportedByAppTupleOfLanguageNameLangCodeList) {
            if (langCode != 'eng' && jsonReplay[langCode] == null) {
              badReplayFromChatGPT = true;
              break;
            }
          }

          return (sentenceDirectory, jsonReplay);
        } catch (e) {
          /// save replay to file 'replay.txt' in directory z:\
          badReplayFromChatGPT = true;
        }
        ++countAttempts;
      } while (badReplayFromChatGPT && countAttempts < maxAttemptsBadReplay);
    } catch (e) {
      print('Exception in translateSentence');
      retryGPTCall = true;
      ++numRetryGPTCall;
      var delay = 10 * numRetryGPTCall * numRetryGPTCall * numRetryGPTCall;
      print('Waiting $delay seconds before retrying');

      /// wait 10*numRetryGPTCall^3 seconds before retrying
      await Future.delayed(Duration(seconds: delay));
    }
  } while (retryGPTCall && numRetryGPTCall < maxRetryGPTCall);
  if (badReplayFromChatGPT) {
    return (sentenceDirectory, <String, dynamic>{});

    // throw InvalidJsonFromChatGPT(
    //     'Invalid Json from ${getFilenameOnly(sentenceDirectory.path)}');
  }
  throw TooManyExceptionsChatGPTRequest(
      'Too many exceptions in translateSentence for directory "$sentenceDirectory"');
}

class CountTokens {
  CountTokens();
  int totalTokens = 0;
  int promptTokens = 0;
  int completionTokens = 0;
}

Future<String> gptConnect(
    List<Map<String, String>> messages, CountTokens countTokens,
    {String addr = 'https://api.openai.com',
    String endPoint = 'v1/chat/completions',
    double temperature = 0.2,
    bool jsonMode = false}) async {
  const url = 'https://api.openai.com/v1/chat/completions';

  var client = http.Client();
  try {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
      'Accept-Charset': 'UTF-8'
    };

    // Set up the request body
    //       'model': 'gpt-3.5-turbo',

    final data = {
      // 'model': 'gpt-3.5-turbo-1106',
      'model': 'gpt-3.5-turbo',
      'messages': messages,
      'temperature': temperature,
      'n': 1,
      // if (jsonMode) "type": "json_object",
      // 'stop': '\n',
    };

    int attempts = 0;
    final exponentialBackOff = ExponentialBackOff(
      interval: const Duration(seconds: 1),
      maxAttempts: 20,
      maxElapsedTime: const Duration(hours: 3),
      maxDelay: const Duration(hours: 3),
    );
    final result = await exponentialBackOff.start<Response>(
      () {
        ++attempts;
        if (attempts > 10) {
          print('Attempt $attempts in gptConnect');
        }
        return client.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      },
    );
    if (result.isLeft()) {
      var ss = result.getLeftValue();
      throw ExceptionMsg(
          'Error in chatGPT connection after $attempts: ${ss.toString()}');
    } else {
      Response response = result.getRightValue();
      if (response.statusCode == 200) {
        var bodyBytes = response.bodyBytes;
        var bodyString = utf8.decode(bodyBytes);
        final jsonResponse = jsonDecode(bodyString);
        final answer = jsonResponse['choices'][0]['message']['content'];
        var usage = jsonResponse['usage'];
        if (usage != null) {
          var promptTokens = usage['prompt_tokens'];
          var completionTokens = usage['completion_tokens'];
          var tokens = usage['total_tokens'];
          if (tokens != null) {
            countTokens.totalTokens += tokens as int;
          }
          if (promptTokens != null) {
            countTokens.promptTokens += promptTokens as int;
          }
          if (completionTokens != null) {
            countTokens.completionTokens += completionTokens as int;
          }
        }
        //print('Answer: $jsonResponse');

        if (answer is! String) {
          throw const ExceptionMsg('Answer is not a string');
        } else {
          return answer;
        }
      } else {
        throw ExceptionMsg(
            'Error in chatGPT connection. Status code: ${response.statusCode}');
      }
    }
  } finally {
    client.close();
  }
}

class TooManyExceptionsChatGPTRequest implements Exception {
  final String message;
  TooManyExceptionsChatGPTRequest(this.message);
}

class InvalidJsonFromChatGPT implements Exception {
  final String message;
  InvalidJsonFromChatGPT(this.message);
}

class ExceptionMsg implements Exception {
  const ExceptionMsg(this.message) : super();
  final String message;
  @override
  String toString() => message;
}

/// print the time taken to call function f
void printTimeTaken(String msg, Function f) {
  var stopwatch = Stopwatch()..start();
  f();
  print('${stopwatch.elapsedMilliseconds / 1000} sec. for $msg');
  stopwatch.stop();
}

/// a StopWatch stack
var stopwatchStack = <Stopwatch>[];

var stopwatch = Stopwatch();
double elapsedTime = 0;
void startStopwatch() {
  stopwatch = Stopwatch();
  stopwatch.start();
  // elapsedTime = 0;

  stopwatchStack.add(stopwatch);
}

void stopPrint(String msg) {
  // stopwatch.stop();
  // elapsedTime = stopwatch.elapsedMilliseconds / 1000.0;
  // print('${elapsedTime} sec. for $msg');
  if (stopwatchStack.isEmpty) {
    print('stopPrint: stopwatchStack is empty');
  } else {
    var stopw = stopwatchStack.removeLast();
    print('${stopw.elapsedMilliseconds / 1000} sec. for $msg');
  }
}

var stopwatchMap = <String, Stopwatch>{};

void startStopwatchMap(String key) {
  var stopwatch = Stopwatch();
  stopwatch.start();
  stopwatchMap[key] = stopwatch;
}

void stopPrintMap(String key, String msg) {
  var stopwatch = stopwatchMap[key];
  if (stopwatch == null) {
    print('stopPrintMap: stopwatchMap[$key] is null');
  } else {
    stopwatch.stop();
    print('${stopwatch.elapsedMilliseconds / 1000} sec. for $msg');
    stopwatchMap.remove(key);
  }
}
