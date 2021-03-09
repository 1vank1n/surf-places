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
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Color(0xFF3B3E5B),
                  fontFamily: 'Roboto',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  height: 36 / 32,
                ),
                children: [
                  TextSpan(
                    text: 'С',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  TextSpan(
                    text: 'писок\n',
                  ),
                  TextSpan(
                    text: 'и',
                    style: TextStyle(
                      color: Color(0xFFFCDD3D),
                    ),
                  ),
                  TextSpan(
                    text: 'нтересных мест',
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
