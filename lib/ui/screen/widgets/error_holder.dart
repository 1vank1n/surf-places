import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class ErrorHolder extends StatelessWidget {
  final String message;

  const ErrorHolder({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 96.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconError,
              width: 64.0,
              height: 64.0,
            ),
            SizedBox(height: 24.0),
            Text(
              'Ошибка',
              style: headline3,
            ),
            SizedBox(height: 8.0),
            Text(
              message,
              style: textBody1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
