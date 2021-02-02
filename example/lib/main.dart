import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Outside Tap Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: _DemoPage(),
        ),
        debugShowCheckedModeBanner: false,
      );
}

class _DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<_DemoPage> {
  final _focusNode = FocusNode(debugLabel: '$_DemoPageState');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 200,
            color: Colors.red[200],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Container(
                  height: 50,
                  width: 300,
                  color: Colors.green[200],
                  child: TextField(
                    focusNode: _focusNode,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
