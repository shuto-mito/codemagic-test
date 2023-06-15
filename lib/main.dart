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
  final List<String> keyEventLogs = [];
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Focus(
          focusNode: focusNode,
          onKey: (_, event) {
            setState(() {
              final updown = event is KeyDownEvent
                  ? "⬇Down"
                  : event is KeyUpEvent
                      ? "⬆Up"
                      : "";
              keyEventLogs.add(
                  '- 🟥RawKeyEvent [${event.logicalKey.keyLabel.toString()}] $updown');
            });
            return KeyEventResult.handled;
          },
          onKeyEvent: (_, event) {
            setState(() {
              final updown = event is KeyDownEvent
                  ? "⬇Down"
                  : event is KeyUpEvent
                      ? "⬆Up"
                      : "";
              keyEventLogs.add(
                  '- 🟦KeyEvent [${event.logicalKey.keyLabel.toString()}] $updown');
            });
            return KeyEventResult.handled;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  textInputAction: TextInputAction.newline,
                  onEditingComplete: () {},
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: keyEventLogs.reversed.map((e) => Text(e)).toList(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
