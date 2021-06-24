import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/model/place.dart';

part 'states.freezed.dart';

@freezed
class PlaceListState with _$PlaceListState {
  const factory PlaceListState([
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isLoading,
    @Default([]) List<Place> places,
    @Default([]) List<Place> favoritePlaces,
    @Default([]) List<Place> visitedPlaces,
  ]) = _PlaceListState;
}
