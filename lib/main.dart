import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstWidget(),
    );
  }
}

class MyFirstWidget extends StatefulWidget {
  @override
  _MyFirstWidgetState createState() => _MyFirstWidgetState();
}

class _MyFirstWidgetState extends State<MyFirstWidget> {
  int _countBuild = 0;

  void _incrementCountBuild() {
    setState(() {
      _countBuild++;
    });

    print('Count build: $_countBuild');
  }

  @override
  Widget build(BuildContext context) {
    _incrementCountBuild();

    return Container(
      child: Center(
        child: Text('Hello'),
      ),
    );
  }
}
