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
class _$PlaceDetailStateTearOff {
  const _$PlaceDetailStateTearOff();

  _PlaceDetailState call(
      [bool isError = false,
      String errorMessage = '',
      bool isLoading = false,
      Place? place]) {
    return _PlaceDetailState(
      isError,
      errorMessage,
      isLoading,
      place,
    );
  }
}

/// @nodoc
const $PlaceDetailState = _$PlaceDetailStateTearOff();

/// @nodoc
mixin _$PlaceDetailState {
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Place? get place => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceDetailStateCopyWith<PlaceDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceDetailStateCopyWith<$Res> {
  factory $PlaceDetailStateCopyWith(
          PlaceDetailState value, $Res Function(PlaceDetailState) then) =
      _$PlaceDetailStateCopyWithImpl<$Res>;
  $Res call({bool isError, String errorMessage, bool isLoading, Place? place});
}

/// @nodoc
class _$PlaceDetailStateCopyWithImpl<$Res>
    implements $PlaceDetailStateCopyWith<$Res> {
  _$PlaceDetailStateCopyWithImpl(this._value, this._then);

  final PlaceDetailState _value;
  // ignore: unused_field
  final $Res Function(PlaceDetailState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
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
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      place: place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Place?,
    ));
  }
}

/// @nodoc
abstract class _$PlaceDetailStateCopyWith<$Res>
    implements $PlaceDetailStateCopyWith<$Res> {
  factory _$PlaceDetailStateCopyWith(
          _PlaceDetailState value, $Res Function(_PlaceDetailState) then) =
      __$PlaceDetailStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isError, String errorMessage, bool isLoading, Place? place});
}

/// @nodoc
class __$PlaceDetailStateCopyWithImpl<$Res>
    extends _$PlaceDetailStateCopyWithImpl<$Res>
    implements _$PlaceDetailStateCopyWith<$Res> {
  __$PlaceDetailStateCopyWithImpl(
      _PlaceDetailState _value, $Res Function(_PlaceDetailState) _then)
      : super(_value, (v) => _then(v as _PlaceDetailState));

  @override
  _PlaceDetailState get _value => super._value as _PlaceDetailState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
    Object? place = freezed,
  }) {
    return _then(_PlaceDetailState(
      isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Place?,
    ));
  }
}

/// @nodoc

class _$_PlaceDetailState implements _PlaceDetailState {
  const _$_PlaceDetailState(
      [this.isError = false,
      this.errorMessage = '',
      this.isLoading = false,
      this.place]);

  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @JsonKey(defaultValue: '')
  @override
  final String errorMessage;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @override
  final Place? place;

  @override
  String toString() {
    return 'PlaceDetailState(isError: $isError, errorMessage: $errorMessage, isLoading: $isLoading, place: $place)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlaceDetailState &&
            (identical(other.isError, isError) ||
                const DeepCollectionEquality()
                    .equals(other.isError, isError)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.place, place) ||
                const DeepCollectionEquality().equals(other.place, place)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(place);

  @JsonKey(ignore: true)
  @override
  _$PlaceDetailStateCopyWith<_PlaceDetailState> get copyWith =>
      __$PlaceDetailStateCopyWithImpl<_PlaceDetailState>(this, _$identity);
}

abstract class _PlaceDetailState implements PlaceDetailState {
  const factory _PlaceDetailState(
      [bool isError,
      String errorMessage,
      bool isLoading,
      Place? place]) = _$_PlaceDetailState;

  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String get errorMessage => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  Place? get place => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PlaceDetailStateCopyWith<_PlaceDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
