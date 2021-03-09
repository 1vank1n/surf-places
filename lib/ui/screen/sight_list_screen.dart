import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              'Список\nинтересных мест',
              style: TextStyle(
                color: Color(0xFF3B3E5B),
                fontFamily: 'Roboto',
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                height: 36 / 32,
              ),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
