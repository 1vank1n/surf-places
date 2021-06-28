import 'package:places/data/redux/place_create/actions.dart';
import 'package:places/data/redux/place_create/states.dart';
import 'package:places/ui/screen/place_create_screen.dart';
import 'package:redux/redux.dart';

final placeCreateReducer = combineReducers<PlaceCreateState>([
  TypedReducer<PlaceCreateState, UploadPlaceCreateAction>(_uploadPlace),
  TypedReducer<PlaceCreateState, SuccessUploadPlaceCreateAction>(_showPlace),
  TypedReducer<PlaceCreateState, ErrorPlaceCreateAction>(_showError),
  TypedReducer<PlaceCreateState, AddImagePlaceCreateAction>(_addImage),
  TypedReducer<PlaceCreateState, RemoveImagePlaceCreateAction>(_removeImage),
  TypedReducer<PlaceCreateState, SetValidPlaceCreateAction>(_setValid),
  TypedReducer<PlaceCreateState, ResetPlaceCreateAction>(_reset),
]);

PlaceCreateState _uploadPlace(
  PlaceCreateState state,
  UploadPlaceCreateAction action,
) =>
    state.copyWith(
      isUploading: true,
      isError: false,
    );

PlaceCreateState _showPlace(
  PlaceCreateState state,
  SuccessUploadPlaceCreateAction action,
) =>
    state.copyWith(
      isUploading: false,
      isError: false,
      place: action.place,
    );

PlaceCreateState _showError(
  PlaceCreateState state,
  ErrorPlaceCreateAction action,
) =>
    state.copyWith(
      isUploading: false,
      isError: true,
      errorMessage: action.message,
    );

PlaceCreateState _addImage(
  PlaceCreateState state,
  AddImagePlaceCreateAction action,
) {
  final uploadImages = state.uploadImages.toList();
  uploadImages.add(action.uploadImage);
  return state.copyWith(uploadImages: uploadImages);
}

PlaceCreateState _removeImage(
  PlaceCreateState state,
  RemoveImagePlaceCreateAction action,
) {
  final uploadImages = state.uploadImages.toList();
  uploadImages.removeWhere((UploadImage uploadImage) => uploadImage.key == action.valueKey);
  return state.copyWith(uploadImages: uploadImages);
}

PlaceCreateState _setValid(
  PlaceCreateState state,
  SetValidPlaceCreateAction action,
) =>
    state.copyWith(isValid: action.isValid);

PlaceCreateState _reset(
  PlaceCreateState state,
  ResetPlaceCreateAction action,
) =>
    PlaceCreateState();
