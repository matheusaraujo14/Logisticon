import 'package:flutter/material.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}

class MyAppColorTest extends StatelessWidget {
  const MyAppColorTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Flutter Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch:
              getMaterialColor(const Color.fromARGB(255, 124, 245, 214)),
        ),
      ),
      home: const MyColorTest(),
    );
  }
}

class MyColorTest extends StatelessWidget {
  const MyColorTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // add a color picker. After the user chooses a color,
            // change the color seed of the theme
            // https://pub.dev/packages/flutter_colorpicker
            // https://stackoverflow.com/questions/63492211/how-to-change-theme-color-dynamically-in-flutter
            // add the code for the color picker here

            Container(
              padding: const EdgeInsets.all(20),
              child: const Text('Lorem Ipsum'),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: const Text('primaryContainer'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        child: const Text('onPrimaryContainer'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: const Text('secondaryContainer'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        child: const Text('onSecondaryContainer'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        child: const Text('tertiaryContainer'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        child: const Text('onTertiaryContainer'),
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
