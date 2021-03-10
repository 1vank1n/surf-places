import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

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
              text: TextSpan(
                style: headingTextStyle,
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
      backgroundColor: Colors.white,
    );
  }
}
