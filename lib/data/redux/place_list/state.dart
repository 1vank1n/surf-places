import 'package:places/data/model/place.dart';

class PlaceListState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final List<Place> places;

  PlaceListState({
    required this.isError,
    required this.errorMessage,
    required this.isLoading,
    required this.places,
  });

  factory PlaceListState.initial() => PlaceListState(
        isError: false,
        errorMessage: '',
        isLoading: false,
        places: const [],
      );

  PlaceListState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isLoading,
    List<Place>? places,
  }) {
    return PlaceListState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      places: places ?? this.places,
    );
  }
}
