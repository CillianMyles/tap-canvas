import 'package:flutter/material.dart';
import 'package:outside_tap/outside_tap.dart';

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
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('FOCUS GAINED');
      } else {
        print('FOCUS LOST');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapWatcher(
        onOutsideTapped: () => print('onOutsideTapped'),
        child: Row(
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
                    height: 60,
                    width: 400,
                    color: Colors.green[200],
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 20,
                            color: Colors.blue[100],
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _textController,
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
