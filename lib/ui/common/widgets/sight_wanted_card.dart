import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';

class SightWantedCard extends StatelessWidget {
  // Карточка достопримечательности для таба «Хочу посетить»

  final Sight sight;

  SightWantedCard(this.sight);

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
              child: Image.network(
                sight.url,
                fit: BoxFit.cover,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CupertinoActivityIndicator.partiallyRevealed(
                      progress: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : 1,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              sight.type.toLowerCase(),
              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            top: 19.0,
            right: 18.0,
            child: Container(
              width: 20.0,
              height: 18.0,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).secondaryHeaderColor,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Запланировано на 12 окт. 2021',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: successColor),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: Theme.of(context).textTheme.bodyText2,
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
