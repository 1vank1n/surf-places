import 'package:places/data/model/place.dart';

abstract class SearchedPlacesState {}

class SearchedPlacesInitialState extends SearchedPlacesState {}

class SearchedPlacesLoadingState extends SearchedPlacesState {}

class SearchedPlacesErrorState extends SearchedPlacesState {
  final String message;

  SearchedPlacesErrorState({required this.message});
}

class SearchedPlacesDataState extends SearchedPlacesState {
  final List<Place> place;

  SearchedPlacesDataState(this.place);
}
