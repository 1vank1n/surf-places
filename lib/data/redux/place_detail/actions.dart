import 'package:places/data/model/place.dart';

abstract class PlaceDetailAction {}

class LoadPlaceDetailAction extends PlaceDetailAction {
  final int placeId;

  LoadPlaceDetailAction({required this.placeId});
}

class ShowPlaceDetailAction extends PlaceDetailAction {
  final Place place;

  ShowPlaceDetailAction({required this.place});
}

class ErrorPlaceDetailAction extends PlaceDetailAction {
  final String message;

  ErrorPlaceDetailAction({required this.message});
}
