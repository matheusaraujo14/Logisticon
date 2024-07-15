import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A Counter example implemented with riverpod

void mainRiverpod() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider.autoDispose((ref) => 0);

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Home build');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a builder widget that allows you to read providers.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${ref.watch(counterProvider)}',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 40),
            Consumer(
              builder: (context, ref, _) {
                final count = ref.watch(counterProvider);
                print('Consumer build: $count');
                return Text(
                  '$count',
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
            const SizedBox(height: 40),

            // a Text button with icon 'remove' that decreases the
            // counter's value
            TextButton(
              onPressed: () {
                // ref.read is another way to read a provider without
                // listening to it
                ref.read(counterProvider.notifier).state--;
              },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () {
          // int count = ref.read(counterProvider.notifier).state;
          // count = ref.watch(counterProvider.notifier).state;

          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ConHome extends StatefulWidget {
  const ConHome({super.key});

  @override
  State<ConHome> createState() => _ConHomeState();
}

class _ConHomeState extends State<ConHome> {
  @override
  Widget build(BuildContext context) {
    print('Home build');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a builder widget that allows you to read providers.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Consumer(
              builder: (context, ref, _) {
                final count = ref.watch(counterProvider);
                print('Consumer build: $count');
                return Text(
                  '$count',
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return FloatingActionButton(
          // The read method is a utility to read a provider without listening to it
          onPressed: () {
            // int count = ref.read(counterProvider.notifier).state;
            // count = ref.watch(counterProvider.notifier).state;

            ref.read(counterProvider.notifier).state++;
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
