import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';

TextStyle _text = const TextStyle(
  color: primaryTextColor,
  fontFamily: 'Roboto',
);

TextStyle headingTextStyle = _text.copyWith(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  height: 36 / 32,
);

TextStyle headingMediumTextStyle = _text.copyWith(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  height: 24 / 18,
);

TextStyle smallBoldTextStyle = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  height: 18 / 14,
);

TextStyle mediumTextStyle = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  height: 20 / 16,
);

TextStyle smallTextStyle = _text.copyWith(
  fontSize: 14.0,
  height: 18 / 14,
  color: Color(0xFF7C7E92),
);

TextStyle titleTextStyle = _text.copyWith(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  height: 28.8 / 24,
);

TextStyle buttonTextStyle = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
  height: 18 / 14,
  color: Colors.white,
);
