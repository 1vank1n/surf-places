import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/model/place.dart';

part 'states.freezed.dart';

@freezed
class PlaceDetailState with _$PlaceDetailState {
  const factory PlaceDetailState([
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isLoading,
    Place? place,
  ]) = _PlaceDetailState;
}
