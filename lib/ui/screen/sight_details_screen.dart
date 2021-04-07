import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight = SightStorage.sights.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            expandedHeight: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  SightImageGallery(),
                  Positioned(
                    top: 36.0,
                    left: 16.0,
                    child: SafeArea(
                      child: Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: SvgPicture.asset(
                            iconArrow,
                            width: 24.0,
                            height: 24.0,
                          ),
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
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
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print('Pressed route button');
                      },
                      icon: SvgPicture.asset(iconGo),
                      label: Text('ПОСТРОИТЬ МАРШРУТ'),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Divider(color: dividerColor),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: TextButton.icon(
                            onPressed: () {
                              print('Pressed calendar button');
                            },
                            icon: SvgPicture.asset(
                              iconCalendar,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: Text(
                              'Запланировать',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: TextButton.icon(
                            onPressed: () {
                              print('Pressed favorite button');
                            },
                            icon: SvgPicture.asset(
                              iconHearth,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: Text(
                              'В Избранное',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SightImageGallery extends StatefulWidget {
  @override
  _SightImageGalleryState createState() => _SightImageGalleryState();
}

class _SightImageGalleryState extends State<SightImageGallery> {
  final PageController _galleryPageController = PageController();

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView(
            controller: _galleryPageController,
            onPageChanged: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            children: [
              for (String url in SightStorage.imageList)
                Image.network(
                  url,
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
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: (currentPageIndex + 1) *
                  MediaQuery.of(context).size.width /
                  SightStorage.imageList.length,
              height: 8.0,
              decoration: BoxDecoration(
                color: overlayBgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
