import 'package:flutter/material.dart';

class CardImage extends StatefulWidget {
  final Widget child;
  final String? heroTag;

  const CardImage({
    Key? key,
    required this.child,
    this.heroTag,
  }) : super(key: key);

  @override
  _CardImageState createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => showImage());
  }

  void showImage() {
    setState(() {
      _opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 300),
      child: Hero(tag: '${widget.heroTag ?? ""}', child: widget.child),
    );
  }
}
