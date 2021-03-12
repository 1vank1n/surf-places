import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  // Карточка достопримечательности. Виджет используется в фиде

  final Sight sight;

  SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              width: double.infinity,
              height: 188.0,
              color: primaryBgColor,
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              sight.type.toLowerCase(),
              style: smallBoldTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 19.0,
            right: 18.0,
            child: Container(
              width: 20.0,
              height: 18.0,
              color: primaryColor,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: secondaryBgColor,
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sight.name,
                        style: mediumTextStyle.copyWith(color: primaryTextColor),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        sight.details,
                        style: smallTextStyle.copyWith(color: secondaryTextColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
