import 'package:places/data/model/place.dart';

class PlaceListState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final List<Place> places;
  final List<Place> favoritePlaces;
  final List<Place> visitedPlaces;

  PlaceListState({
    required this.isError,
    required this.errorMessage,
    required this.isLoading,
    required this.places,
    required this.favoritePlaces,
    required this.visitedPlaces,
  });

  factory PlaceListState.initial() => PlaceListState(
        isError: false,
        errorMessage: '',
        isLoading: false,
        places: const [],
        favoritePlaces: const [],
        visitedPlaces: const [],
      );

  PlaceListState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isLoading,
    List<Place>? places,
    List<Place>? favoritePlaces,
    List<Place>? visitedPlaces,
  }) {
    return PlaceListState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      places: places ?? this.places,
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
      visitedPlaces: visitedPlaces ?? this.visitedPlaces,
    );
  }
}
