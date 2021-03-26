import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';

/// Карточка достопримечательности для таба «Хочу посетить»
class SightWantedCard extends StatelessWidget {
  final Sight sight;
  final Function removeHandler;

  SightWantedCard({
    required this.sight,
    required this.removeHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
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
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    child: IconButton(
                      onPressed: () {
                        print('Pressed calendar button');
                      },
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        iconCalendar,
                        color: Colors.white,
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    child: IconButton(
                      onPressed: () {
                        removeHandler();
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
