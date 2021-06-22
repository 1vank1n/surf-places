import 'package:flutter/material.dart';
import 'dart:math';
import 'package:places/ui/res/icons.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  static const ROTATION_DURATION = 1000;
  static const ROTATION_DURATION = Duration(milliseconds: 1000);
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: ROTATION_DURATION,
    )..repeat();

    _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? widget) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Image.asset(
            iconLoader,
            width: 36,
            height: 36,
          ),
        );
      },
    );
  }
}
