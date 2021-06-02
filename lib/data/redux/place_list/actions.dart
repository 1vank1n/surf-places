import 'package:places/data/model/place.dart';

abstract class PlaceListAction {}

class LoadPlaceListAction extends PlaceListAction {}

class ShowPlaceListAction extends PlaceListAction {
  final List<Place> places;

  ShowPlaceListAction({required this.places});
}

class ErrorPlaceListAction extends PlaceListAction {
  final String message;

  ErrorPlaceListAction(this.message);
}
