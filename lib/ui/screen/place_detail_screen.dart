import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';

class PlaceDetailScreen extends StatefulWidget {
  final int id;

  const PlaceDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final PlaceInteractor _placeInteractor = PlaceInteractor();
  final StreamController<Place> _placeStreamController = StreamController();
  final StreamController<bool> _favoriteStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    _getPlace();
  }

  void dispose() {
    super.dispose();
    _placeStreamController.close();
    _favoriteStreamController.close();
  }

  void _getPlace() {
    _placeInteractor.getPlaceDetails(widget.id).then((place) {
      if (place != null) {
        _placeStreamController.sink.add(place);
        _favoriteStreamController.sink.add(_placeInFavorites(place));
      }
    }).onError(
      (error, stackTrace) {
        if (error != null) _placeStreamController.addError(error);
      },
    );
  }

  bool _placeInFavorites(Place place) {
    return _placeInteractor.getFavoritesPlaces().contains(place);
  }

  void _addToFavorites(Place place) {
    _placeInteractor.addToFavorites(place);
    _favoriteStreamController.sink.add(true);
  }

  void _removeFromFavorites(Place place) {
    _placeInteractor.removeFromFavorites(place);
    _favoriteStreamController.sink.add(false);
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 64;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Scaffold(
          body: StreamBuilder<Place>(
            stream: _placeStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                String message;

                try {
                  DioError dioError = snapshot.error as DioError;
                  NetworkException networkException = dioError.error as NetworkException;
                  message = networkException.toString();
                } on TypeError {
                  message = 'Что-то пошло не так попробуйте позже';
                }

                return ErrorHolder(
                  message: message,
                );
              } else {
                final place = snapshot.data!;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: Container(),
                      expandedHeight:
                          MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SightImageGallery(imageUrls: place.urls),
                            Positioned(
                              top: 12.0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 40.0,
                                  height: 4.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16.0,
                              right: 16.0,
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: SvgPicture.asset(
                                    iconClose,
                                    width: 24.0,
                                    height: 24.0,
                                  ),
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
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
                              place.name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  place.placeType.toLowerCase(),
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
                              place.description,
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
                                    child: StreamBuilder<bool>(
                                        stream: _favoriteStreamController.stream,
                                        builder:
                                            (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                          bool isFavorite = snapshot.data ?? false;

                                          return TextButton.icon(
                                            onPressed: () {
                                              isFavorite
                                                  ? _removeFromFavorites(place)
                                                  : _addToFavorites(place);
                                            },
                                            icon: SvgPicture.asset(
                                              isFavorite ? iconHeartFill : iconHeart,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            label: Text(
                                              'В Избранное',
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SightImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const SightImageGallery({
    Key? key,
    required this.imageUrls,
  }) : super(key: key);

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
              for (String url in widget.imageUrls)
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
                  widget.imageUrls.length,
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
