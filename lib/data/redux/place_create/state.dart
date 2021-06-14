import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_create_screen.dart';

class PlaceCreateState {
  final bool isError;
  final String errorMessage;
  final bool isUploading;
  final bool isValid;
  final List<UploadImage> uploadImages;
  final Place? place;

  PlaceCreateState({
    required this.isError,
    required this.errorMessage,
    required this.isUploading,
    required this.isValid,
    required this.uploadImages,
    this.place,
  });

  factory PlaceCreateState.initial() => PlaceCreateState(
        isError: false,
        errorMessage: '',
        isUploading: false,
        isValid: false,
        uploadImages: const [],
      );

  PlaceCreateState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isUploading,
    bool? isValid,
    List<UploadImage>? uploadImages,
    Place? place,
  }) {
    return PlaceCreateState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isUploading: isUploading ?? this.isUploading,
      isValid: isValid ?? this.isValid,
      uploadImages: uploadImages ?? this.uploadImages,
      place: place ?? this.place,
    );
  }
}
