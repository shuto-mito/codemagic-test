import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> logs = [];
  final keyboardFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: KeyboardListener(
          focusNode: keyboardFocusNode,
          onKeyEvent: (event) {
            if (event.logicalKey == LogicalKeyboardKey.enter && event is KeyDownEvent) {
              setState(() {
                logs.add('Press enter');
              });
            } else if (event.logicalKey == LogicalKeyboardKey.backspace && event is KeyDownEvent) {
               setState(() {
                logs.add('Press backspace');
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(padding: const EdgeInsets.all(10.0),
                child: TextField(
                  textInputAction: TextInputAction.newline,
                  onEditingComplete: () {},
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: logs.map((e) => Text(e)).toList(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
