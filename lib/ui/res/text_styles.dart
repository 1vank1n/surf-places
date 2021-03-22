import 'package:flutter/material.dart';

TextStyle _text = const TextStyle(
  fontFamily: 'Roboto',
);

TextStyle headline1 = _text.copyWith(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  height: 36 / 32,
);

TextStyle headline2 = _text.copyWith(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  height: 28.8 / 24,
);

TextStyle headline3 = _text.copyWith(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  height: 24 / 18,
);

TextStyle headline4 = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  height: 18 / 14,
);

TextStyle headline5 = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  height: 20 / 16,
);

TextStyle textBody1 = _text.copyWith(
  fontSize: 14.0,
  height: 18 / 14,
);

TextStyle textBody2 = _text.copyWith(
  fontSize: 14.0,
  height: 18 / 14,
);

TextStyle button = _text.copyWith(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
  height: 18 / 14,
);

TextStyle subtitle1 = _text.copyWith(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  height: 20 / 16,
);

TextStyle subtitle2 = _text.copyWith(
  fontSize: 12.0,
  height: 16 / 12,
);
