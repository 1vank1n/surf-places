import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/main.dart' show AppRouter;
import 'package:places/ui/res/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const TIMEOUT_SECONDS = 2;
  late Future isInitialized;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(Duration(seconds: TIMEOUT_SECONDS), () {
      Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            warningColor,
            successColor,
          ],
        ),
      ),
      child: Center(
        child: SvgPicture.asset('res/logo.svg'),
      ),
    );
  }
}
