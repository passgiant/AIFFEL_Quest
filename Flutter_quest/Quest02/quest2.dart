import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          centerTitle: true,
          title: const Text(
            '플러터 앱 만들기',
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  print('버튼이 눌렸습니다.');
                },
                child: const Text('Text'),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.75),
              child: Stack(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.red,
                  ),
                  Container(
                    width: 240,
                    height: 240,
                    color: Colors.orange,
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.green,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.blue,
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
