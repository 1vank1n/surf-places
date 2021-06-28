// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlaceCreateStateTearOff {
  const _$PlaceCreateStateTearOff();

  _PlaceCreateState call(
      [bool isError = false,
      String errorMessage = '',
      bool isUploading = false,
      bool isValid = false,
      List<UploadImage> uploadImages = const [],
      Place? place]) {
    return _PlaceCreateState(
      isError,
      errorMessage,
      isUploading,
      isValid,
      uploadImages,
      place,
    );
  }
}

/// @nodoc
const $PlaceCreateState = _$PlaceCreateStateTearOff();

/// @nodoc
mixin _$PlaceCreateState {
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isUploading => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  List<UploadImage> get uploadImages => throw _privateConstructorUsedError;
  Place? get place => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceCreateStateCopyWith<PlaceCreateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCreateStateCopyWith<$Res> {
  factory $PlaceCreateStateCopyWith(
          PlaceCreateState value, $Res Function(PlaceCreateState) then) =
      _$PlaceCreateStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      String errorMessage,
      bool isUploading,
      bool isValid,
      List<UploadImage> uploadImages,
      Place? place});
}

/// @nodoc
class _$PlaceCreateStateCopyWithImpl<$Res>
    implements $PlaceCreateStateCopyWith<$Res> {
  _$PlaceCreateStateCopyWithImpl(this._value, this._then);

  final PlaceCreateState _value;
  // ignore: unused_field
  final $Res Function(PlaceCreateState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isUploading = freezed,
    Object? isValid = freezed,
    Object? uploadImages = freezed,
    Object? place = freezed,
  }) {
    return _then(_value.copyWith(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isUploading: isUploading == freezed
          ? _value.isUploading
          : isUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      uploadImages: uploadImages == freezed
          ? _value.uploadImages
          : uploadImages // ignore: cast_nullable_to_non_nullable
              as List<UploadImage>,
      place: place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Place?,
    ));
  }
}

/// @nodoc
abstract class _$PlaceCreateStateCopyWith<$Res>
    implements $PlaceCreateStateCopyWith<$Res> {
  factory _$PlaceCreateStateCopyWith(
          _PlaceCreateState value, $Res Function(_PlaceCreateState) then) =
      __$PlaceCreateStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      String errorMessage,
      bool isUploading,
      bool isValid,
      List<UploadImage> uploadImages,
      Place? place});
}

/// @nodoc
class __$PlaceCreateStateCopyWithImpl<$Res>
    extends _$PlaceCreateStateCopyWithImpl<$Res>
    implements _$PlaceCreateStateCopyWith<$Res> {
  __$PlaceCreateStateCopyWithImpl(
      _PlaceCreateState _value, $Res Function(_PlaceCreateState) _then)
      : super(_value, (v) => _then(v as _PlaceCreateState));

  @override
  _PlaceCreateState get _value => super._value as _PlaceCreateState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isUploading = freezed,
    Object? isValid = freezed,
    Object? uploadImages = freezed,
    Object? place = freezed,
  }) {
    return _then(_PlaceCreateState(
      isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isUploading == freezed
          ? _value.isUploading
          : isUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      uploadImages == freezed
          ? _value.uploadImages
          : uploadImages // ignore: cast_nullable_to_non_nullable
              as List<UploadImage>,
      place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Place?,
    ));
  }
}

/// @nodoc

class _$_PlaceCreateState implements _PlaceCreateState {
  const _$_PlaceCreateState(
      [this.isError = false,
      this.errorMessage = '',
      this.isUploading = false,
      this.isValid = false,
      this.uploadImages = const [],
      this.place]);

  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @JsonKey(defaultValue: '')
  @override
  final String errorMessage;
  @JsonKey(defaultValue: false)
  @override
  final bool isUploading;
  @JsonKey(defaultValue: false)
  @override
  final bool isValid;
  @JsonKey(defaultValue: const [])
  @override
  final List<UploadImage> uploadImages;
  @override
  final Place? place;

  @override
  String toString() {
    return 'PlaceCreateState(isError: $isError, errorMessage: $errorMessage, isUploading: $isUploading, isValid: $isValid, uploadImages: $uploadImages, place: $place)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlaceCreateState &&
            (identical(other.isError, isError) ||
                const DeepCollectionEquality()
                    .equals(other.isError, isError)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.isUploading, isUploading) ||
                const DeepCollectionEquality()
                    .equals(other.isUploading, isUploading)) &&
            (identical(other.isValid, isValid) ||
                const DeepCollectionEquality()
                    .equals(other.isValid, isValid)) &&
            (identical(other.uploadImages, uploadImages) ||
                const DeepCollectionEquality()
                    .equals(other.uploadImages, uploadImages)) &&
            (identical(other.place, place) ||
                const DeepCollectionEquality().equals(other.place, place)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(isUploading) ^
      const DeepCollectionEquality().hash(isValid) ^
      const DeepCollectionEquality().hash(uploadImages) ^
      const DeepCollectionEquality().hash(place);

  @JsonKey(ignore: true)
  @override
  _$PlaceCreateStateCopyWith<_PlaceCreateState> get copyWith =>
      __$PlaceCreateStateCopyWithImpl<_PlaceCreateState>(this, _$identity);
}

abstract class _PlaceCreateState implements PlaceCreateState {
  const factory _PlaceCreateState(
      [bool isError,
      String errorMessage,
      bool isUploading,
      bool isValid,
      List<UploadImage> uploadImages,
      Place? place]) = _$_PlaceCreateState;

  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String get errorMessage => throw _privateConstructorUsedError;
  @override
  bool get isUploading => throw _privateConstructorUsedError;
  @override
  bool get isValid => throw _privateConstructorUsedError;
  @override
  List<UploadImage> get uploadImages => throw _privateConstructorUsedError;
  @override
  Place? get place => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PlaceCreateStateCopyWith<_PlaceCreateState> get copyWith =>
      throw _privateConstructorUsedError;
}
