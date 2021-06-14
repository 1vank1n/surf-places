import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/place_detail/actions.dart';
import 'package:places/data/redux/place_detail/state.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:redux/redux.dart';

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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(LoadPlaceDetailAction(placeId: widget.id));
  }

  void _addToFavorites(Store<AppState> store, Place place) {
    store.dispatch(AddPlaceToFavoritesPlaceListAction(place: place));
  }

  void _removeFromFavorites(Store<AppState> store, Place place) {
    store.dispatch(RemovePlaceFromFavoritesPlaceListAction(place: place));
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
          body: StoreConnector<AppState, PlaceDetailState>(
            converter: (Store<AppState> store) => store.state.placeDetailState,
            builder: (BuildContext context, PlaceDetailState state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                ErrorHolder(
                  message: state.errorMessage,
                );
              } else if (state.place != null) {
                final place = state.place!;

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
                                    child: StoreConnector<AppState, PlaceListState>(
                                        converter: (Store<AppState> store) =>
                                            store.state.placeListState,
                                        builder: (BuildContext context, PlaceListState state) {
                                          bool isFavorited = state.favoritePlaces.contains(place);
                                          Store<AppState> store =
                                              StoreProvider.of<AppState>(context);

                                          return TextButton.icon(
                                            onPressed: () {
                                              isFavorited
                                                  ? _removeFromFavorites(store, place)
                                                  : _addToFavorites(store, place);
                                            },
                                            icon: SvgPicture.asset(
                                              isFavorited ? iconHeartFill : iconHeart,
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
              return Container();
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
