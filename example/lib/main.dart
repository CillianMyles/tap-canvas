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
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            children: [
              Container(
                width: 200,
                color: Colors.redAccent,
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
}
