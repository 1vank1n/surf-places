import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_create_screen.dart';

part 'states.freezed.dart';

@freezed
class PlaceCreateState with _$PlaceCreateState {
  const factory PlaceCreateState([
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isUploading,
    @Default(false) bool isValid,
    @Default([]) List<UploadImage> uploadImages,
    Place? place,
  ]) = _PlaceCreateState;
}
