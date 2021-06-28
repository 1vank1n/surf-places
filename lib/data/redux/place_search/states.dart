import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/model/place.dart';

part 'states.freezed.dart';

@freezed
class PlaceSearchState with _$PlaceSearchState {
  const factory PlaceSearchState([
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isLoading,
    @Default(true) bool isShowQueriesHistory,
    @Default([]) List<String> queries,
    @Default([]) List<Place> places,
  ]) = _PlaceSearchState;
}
