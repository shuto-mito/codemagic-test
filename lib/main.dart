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
  final List<String> keyboardListenerLogs = [];
  final List<String> focusNodeLogs = [];
  final List<String> focusWidgetLogs = [];
  final keyboardFocusNode = FocusNode();
  final focusWidgetFocusNode = FocusNode();
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode(
      onKey: (_, event) {
        setState(() {
          final updown = event is KeyDownEvent
              ? "⬇Down"
              : event is KeyUpEvent
                  ? "⬆Up"
                  : "";
          focusNodeLogs.add(
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
          focusNodeLogs.add(
              '- 🟦KeyEvent [${event.logicalKey.keyLabel.toString()}] $updown');
        });
        return KeyEventResult.handled;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'KeyboardListener',
              ),
              Tab(text: 'FocusNode'),
              Tab(text: 'FocusWidget'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: KeyboardListener(
                focusNode: keyboardFocusNode,
                onKeyEvent: (event) {
                  final updown = event is KeyDownEvent
                      ? "⬇Down"
                      : event is KeyUpEvent
                          ? "⬆Up"
                          : "";
                  setState(() {
                    keyboardListenerLogs.add(
                        '- [${event.logicalKey.keyLabel.toString()}] $updown');
                  });
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
                        children: keyboardListenerLogs.reversed
                            .map((e) => Text(e))
                            .toList(),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      onEditingComplete: () {},
                      focusNode: focusNode,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: focusNodeLogs.reversed.map((e) => Text(e)).toList(),
                    ),
                  )),
                ],
              ),
            ),
            Center(
              child: Focus(
                focusNode: focusWidgetFocusNode,
                onKey: (_, event) {
                  setState(() {
                    final updown = event is KeyDownEvent
                        ? "⬇Down"
                        : event is KeyUpEvent
                            ? "⬆Up"
                            : "";
                    focusWidgetLogs.add(
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
                    focusWidgetLogs.add(
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
                        children:
                            focusWidgetLogs.reversed.map((e) => Text(e)).toList(),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
