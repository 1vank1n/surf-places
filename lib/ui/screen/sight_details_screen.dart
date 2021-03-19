import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight = mocks.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
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
                  top: 36.0,
                  left: 16.0,
                  child: SafeArea(
                    child: Container(
                      width: 36.0,
                      height: 36.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    sight.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    children: [
                      Text(
                        sight.type.toLowerCase(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        'закрыто до 09:00',
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    sight.details,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    height: 48.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: successColor,
                        elevation: 0,
                      ),
                      child: Text(
                        'ПОСТРОИТЬ МАРШРУТ',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Divider(
                    color: dividerColor,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: Opacity(
                            opacity: 0.56,
                            child: TextButton(
                              child: Text(
                                'Запланировать',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: TextButton(
                            child: Text(
                              'В Избранное',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
