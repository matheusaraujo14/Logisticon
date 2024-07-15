import 'package:flutter/material.dart';
import 'package:new_test/widget_lib/wutils.dart';

class PopUpMenuTest extends StatefulWidget {
  const PopUpMenuTest({Key? key}) : super(key: key);

  @override
  PopUpMenuTestState createState() => PopUpMenuTestState();
}

class PopUpMenuTestState extends State<PopUpMenuTest> {
  var selectedIndexFruit = ValueNotifier<int>(0);
  var selectedIndexPlanet = ValueNotifier<int>(0);
  var selectedIndexCountry = ValueNotifier<int>(0);
  var selectedIndexColor = ValueNotifier<int>(0);
  final fruitList = ['Strawberry', 'Apple', 'Banana', 'Mango', 'Orange'];
  final planetList = const ['Earth', 'Saturn', 'Mercurius', 'Mars', 'Venus'];
  final countryList = const ['Brazil', 'Uruguai', 'France', 'Germany', 'China'];

  final colorList = const ['Blue', 'Green', 'Red', 'Tea', 'Orange'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Card',
      home: Scaffold(
        body: Center(
          // child: AnimatedElevationCard(),
          child: SizedBox(
            width: 650,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CwPopupMenuButton(
                      options: fruitList,
                      selectedIndex: selectedIndexFruit,
                    ),
                    CwPopupMenuButton(
                      options: planetList,
                      selectedIndex: selectedIndexPlanet,
                    ),
                    CwPopupMenuButton(
                      options: countryList,
                      selectedIndex: selectedIndexCountry,
                    ),
                    CwPopupMenuButton(
                      options: colorList,
                      selectedIndex: selectedIndexColor,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CwText('Fruit: ${fruitList[selectedIndexFruit.value]}'),
                    CwText('Planet: ${planetList[selectedIndexPlanet.value]}'),
                    CwText(
                        'Country: ${countryList[selectedIndexCountry.value]}'),
                    CwText('Color: ${colorList[selectedIndexColor.value]}'),
                  ],
                ),
                // add a horizontal space of 30
                const SizedBox(height: 30),
                // an elevated button 'Update' that just calls setState
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
          //child: ShowMyMenu(),
          //child: CustomPopupMenuWidget(),
        ),
      ),
    );
  }
}

class AnimatedTest extends StatelessWidget {
  const AnimatedTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animated Card',
      home: Scaffold(
        body: Center(
          // child: AnimatedElevationCard(),
          child: AnimatedBuilderExample(),
        ),
      ),
    );
  }
}

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({super.key});

  @override
  State<AnimatedBuilderExample> createState() => _AnimatedBuilderExampleState();
}

/// AnimationControllers can be created with `vsync: this` because of
/// TickerProviderStateMixin.
class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool stopped = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            //_controller.forward(from: 0.0);
            if (stopped) {
              _controller.repeat();
              stopped = false;
            } else {
              _controller.stop();
              stopped = true;
            }
          },
          child: Card(
            elevation: _controller.value * 28 + 2,
            shadowColor: _controller.value > 0.5
                ? const Color.fromARGB(255, 255, 67, 15)
                : Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0 + 10 * _controller.value),
              ),
            ),
            child: SizedBox(
              width: 120.0 + 100 * _controller.value,
              height: 50.0 + 50 * _controller.value,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FittedBox(
                    child: Text("(a) an option"),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimatedElevationCard extends StatefulWidget {
  const AnimatedElevationCard({super.key});

  @override
  AnimatedElevationCardState createState() => AnimatedElevationCardState();
}

class AnimatedElevationCardState extends State<AnimatedElevationCard> {
  bool _isElevated = false;

  void _toggleElevation() {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleElevation();
      },
      child: AnimatedPhysicalModel(
        color: Colors.blue.shade300, // Add the required 'color' argument here
        borderRadius: BorderRadius.circular(12.0),
        elevation: _isElevated ? 12.0 : 2.0,
        shape: BoxShape.rectangle,
        shadowColor: Colors.blue.shade900,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: const Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("(a) an option"),
          ),
        ),
      ),
    );
  }
}

class CustomPopupMenuWidget extends StatefulWidget {
  const CustomPopupMenuWidget({super.key});

  @override
  CustomPopupMenuWidgetState createState() => CustomPopupMenuWidgetState();
}

class CustomPopupMenuWidgetState extends State<CustomPopupMenuWidget> {
  late GlobalKey actionKey;
  String _selectedItem = 'Item 1'; // Default selected item

  @override
  void initState() {
    super.initState();
    actionKey = LabeledGlobalKey('PopupMenuButton');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox renderBox =
            actionKey.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        showPopupMenu(position, context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(key: actionKey, _selectedItem),
      ),
    );
  }

  void showPopupMenu(Offset offset, BuildContext context) async {
    final selectedItem = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy + 20, offset.dx,
          offset.dy), // Position the menu exactly above the text
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'Item 1',
          child: Text('Item 1'),
        ),
        const PopupMenuItem(
          value: 'Item 2',
          child: Text('Item 2'),
        ),
        const PopupMenuItem(
          value: 'Item 3',
          child: Text('Item 3'),
        ),
      ],
    );
    if (selectedItem != null) {
      setState(() {
        _selectedItem = selectedItem;
      });
    }
  }
}

// create a ShowMyMenu statefull widget
class ShowMyMenu extends StatefulWidget {
  const ShowMyMenu({super.key});

  @override
  State<ShowMyMenu> createState() => ShowMyMenuState();
}

class ShowMyMenuState extends State<ShowMyMenu> {
  late GlobalKey actionKey;
  String _selectedItem = 'Item 1'; // Default selected item

  @override
  void initState() {
    super.initState();
    actionKey = LabeledGlobalKey('PopupMenuButton');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 30),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15.0), // Circular borders for the menu
      ),
      shadowColor: Theme.of(context).colorScheme.secondary,
      clipBehavior: Clip.antiAlias,
      tooltip: 'Choose one',
      child: TextButton(
        onPressed: null,
        // Text button with rounded corners
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor:
              Colors.amber.shade100, //Theme.of(context).colorScheme.tertiary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Text(_selectedItem),
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'Item 1',
            child: ElevatedButton(onPressed: null, child: Text('Item 1')),
          ),
          const PopupMenuItem(
            value: 'Item 2',
            child: Text('Item 2'),
          ),
          const PopupMenuItem(
            value: 'Item 3',
            child: Text('Item 3'),
          ),
        ];
      },
      onSelected: (value) {
        setState(() {
          _selectedItem = value as String;
        });
      },
    );
  }
}
