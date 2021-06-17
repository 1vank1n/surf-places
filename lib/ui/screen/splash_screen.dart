import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  static const TIMEOUT_SECONDS = 4;
  late AnimationController _logoAnimationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: false);

    _rotateAnimation = Tween<double>(begin: 0, end: -pi * 2).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
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
        child: AnimatedBuilder(
          animation: _logoAnimationController,
          builder: (BuildContext context, Widget? widget) {
            return Transform.rotate(
              angle: _rotateAnimation.value,
              child: SvgPicture.asset('res/logo.svg'),
            );
          },
        ),
      ),
    );
  }
}
