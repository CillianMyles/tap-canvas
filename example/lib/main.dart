import 'package:flutter/material.dart';
import 'package:tap_canvas/tap_canvas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Tap Canvas Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const Scaffold(
          backgroundColor: Colors.white,
          body: DemoPage(),
        ),
        debugShowCheckedModeBanner: false,
      );
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  final _focusNode = FocusNode(debugLabel: '$DemoPageState');
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        debugPrint('FOCUS GAINED');
      } else {
        debugPrint('FOCUS LOST');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapCanvas(
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
                  child: TapOutsideDetectorWidget(
                    onTappedOutside: () {
                      debugPrint('OUTSIDE TAPPED');
                      _focusNode.unfocus();
                    },
                    onTappedInside: () {
                      debugPrint('INSIDE TAPPED');
                      _focusNode.requestFocus();
                    },
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
            ),
          ],
        ),
      );
}
