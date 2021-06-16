import 'package:flutter/material.dart';

class TextBoxDecoration extends Decoration {
  final TextSpan text;
  final BoxDecoration boxDecoration;
  final Color color;
  final double opacity;

  TextBoxDecoration({
    required this.text,
    required this.boxDecoration,
    this.color = Colors.white,
    this.opacity = 1,
  });

  @override
  _TextBoxDecorationPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TextBoxDecorationPainter(
      this.text,
      this.boxDecoration,
      this.color,
      this.opacity,
      onChanged,
    );
  }
}

class _TextBoxDecorationPainter extends BoxPainter {
  final TextSpan _text;
  final BoxDecoration _decoration;
  final Color _color;
  final double _opacity;

  _TextBoxDecorationPainter(
    this._text,
    this._decoration,
    this._color,
    this._opacity,
    VoidCallback? onChanged,
  ) : super(onChanged);

  void _paintText(Canvas canvas, Rect rect) {
    final _textSpan = TextSpan(
      text: _text.text,
      style: _text.style!.copyWith(color: _color.withOpacity(_opacity)),
    );

    final textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );
    final size = rect.size;
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = rect.left + (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    _decoration.createBoxPainter().paint(canvas, offset, configuration);
    _paintText(canvas, rect);
  }

  @override
  String toString() {
    return 'BoxPainter for $_decoration';
  }
}
