import 'package:places/data/model/place.dart';

abstract class PlaceListAction {}

class LoadPlaceListAction extends PlaceListAction {}

class ShowPlaceListAction extends PlaceListAction {
  final List<Place> places;

  ShowPlaceListAction({required this.places});
}

class ErrorPlaceListAction extends PlaceListAction {
  final String message;

  ErrorPlaceListAction({required this.message});
}

class AddPlaceToFavoritesPlaceListAction extends PlaceListAction {
  final Place place;

  AddPlaceToFavoritesPlaceListAction({required this.place});
}

class RemovePlaceFromFavoritesPlaceListAction extends PlaceListAction {
  final Place place;

  RemovePlaceFromFavoritesPlaceListAction({required this.place});
}

class AddPlaceToVisitedPlaceListAction extends PlaceListAction {
  final Place place;

  AddPlaceToVisitedPlaceListAction({required this.place});
}

class RemovePlaceFromVisitedPlaceListAction extends PlaceListAction {
  final Place place;

  RemovePlaceFromVisitedPlaceListAction({required this.place});
}
