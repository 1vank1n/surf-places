import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 188.0,
            color: Colors.black26,
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
              color: Colors.black12,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: Colors.white12,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.name,
                    style: mediumTextStyle.copyWith(color: Color(0xFF3B3E5B)),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    sight.details,
                    style: smallTextStyle.copyWith(color: Color(0xFF7C7E92)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
