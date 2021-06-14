import 'package:places/data/model/place.dart';

class PlaceDetailState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final Place? place;

  PlaceDetailState({
    required this.isError,
    required this.errorMessage,
    required this.isLoading,
    this.place,
  });

  factory PlaceDetailState.initial() => PlaceDetailState(
        isError: false,
        errorMessage: '',
        isLoading: false,
      );

  PlaceDetailState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isLoading,
    Place? place,
  }) {
    return PlaceDetailState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      place: place ?? this.place,
    );
  }
}
