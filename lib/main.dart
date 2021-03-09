import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyFirstWidget(),
//     );
//   }
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App title',
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

  Type _getContextRuntimeType() {
    return context.runtimeType;
  }

  @override
  Widget build(BuildContext context) {
    _incrementCountBuild();
    print(_getContextRuntimeType());

    return Container(
      child: Center(
        child: Text('Hello state'),
      ),
    );
  }
}

class MyFirstStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Type _getContextRuntimeType() {
      return context.runtimeType;
    }

    print(_getContextRuntimeType());

    return Container(
      child: Center(
        child: Text('Goodbye state'),
      ),
    );
  }
}
