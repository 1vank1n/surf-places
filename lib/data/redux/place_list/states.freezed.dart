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
class _$PlaceListStateTearOff {
  const _$PlaceListStateTearOff();

  _PlaceListState call(
      [bool isError = false,
      String errorMessage = '',
      bool isLoading = false,
      List<Place> places = const [],
      List<Place> favoritePlaces = const [],
      List<Place> visitedPlaces = const []]) {
    return _PlaceListState(
      isError,
      errorMessage,
      isLoading,
      places,
      favoritePlaces,
      visitedPlaces,
    );
  }
}

/// @nodoc
const $PlaceListState = _$PlaceListStateTearOff();

/// @nodoc
mixin _$PlaceListState {
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<Place> get places => throw _privateConstructorUsedError;
  List<Place> get favoritePlaces => throw _privateConstructorUsedError;
  List<Place> get visitedPlaces => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceListStateCopyWith<PlaceListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceListStateCopyWith<$Res> {
  factory $PlaceListStateCopyWith(
          PlaceListState value, $Res Function(PlaceListState) then) =
      _$PlaceListStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      String errorMessage,
      bool isLoading,
      List<Place> places,
      List<Place> favoritePlaces,
      List<Place> visitedPlaces});
}

/// @nodoc
class _$PlaceListStateCopyWithImpl<$Res>
    implements $PlaceListStateCopyWith<$Res> {
  _$PlaceListStateCopyWithImpl(this._value, this._then);

  final PlaceListState _value;
  // ignore: unused_field
  final $Res Function(PlaceListState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
    Object? places = freezed,
    Object? favoritePlaces = freezed,
    Object? visitedPlaces = freezed,
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
      places: places == freezed
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<Place>,
      favoritePlaces: favoritePlaces == freezed
          ? _value.favoritePlaces
          : favoritePlaces // ignore: cast_nullable_to_non_nullable
              as List<Place>,
      visitedPlaces: visitedPlaces == freezed
          ? _value.visitedPlaces
          : visitedPlaces // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc
abstract class _$PlaceListStateCopyWith<$Res>
    implements $PlaceListStateCopyWith<$Res> {
  factory _$PlaceListStateCopyWith(
          _PlaceListState value, $Res Function(_PlaceListState) then) =
      __$PlaceListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      String errorMessage,
      bool isLoading,
      List<Place> places,
      List<Place> favoritePlaces,
      List<Place> visitedPlaces});
}

/// @nodoc
class __$PlaceListStateCopyWithImpl<$Res>
    extends _$PlaceListStateCopyWithImpl<$Res>
    implements _$PlaceListStateCopyWith<$Res> {
  __$PlaceListStateCopyWithImpl(
      _PlaceListState _value, $Res Function(_PlaceListState) _then)
      : super(_value, (v) => _then(v as _PlaceListState));

  @override
  _PlaceListState get _value => super._value as _PlaceListState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
    Object? places = freezed,
    Object? favoritePlaces = freezed,
    Object? visitedPlaces = freezed,
  }) {
    return _then(_PlaceListState(
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
      places == freezed
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<Place>,
      favoritePlaces == freezed
          ? _value.favoritePlaces
          : favoritePlaces // ignore: cast_nullable_to_non_nullable
              as List<Place>,
      visitedPlaces == freezed
          ? _value.visitedPlaces
          : visitedPlaces // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc

class _$_PlaceListState implements _PlaceListState {
  const _$_PlaceListState(
      [this.isError = false,
      this.errorMessage = '',
      this.isLoading = false,
      this.places = const [],
      this.favoritePlaces = const [],
      this.visitedPlaces = const []]);

  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @JsonKey(defaultValue: '')
  @override
  final String errorMessage;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @JsonKey(defaultValue: const [])
  @override
  final List<Place> places;
  @JsonKey(defaultValue: const [])
  @override
  final List<Place> favoritePlaces;
  @JsonKey(defaultValue: const [])
  @override
  final List<Place> visitedPlaces;

  @override
  String toString() {
    return 'PlaceListState(isError: $isError, errorMessage: $errorMessage, isLoading: $isLoading, places: $places, favoritePlaces: $favoritePlaces, visitedPlaces: $visitedPlaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlaceListState &&
            (identical(other.isError, isError) ||
                const DeepCollectionEquality()
                    .equals(other.isError, isError)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.places, places) ||
                const DeepCollectionEquality().equals(other.places, places)) &&
            (identical(other.favoritePlaces, favoritePlaces) ||
                const DeepCollectionEquality()
                    .equals(other.favoritePlaces, favoritePlaces)) &&
            (identical(other.visitedPlaces, visitedPlaces) ||
                const DeepCollectionEquality()
                    .equals(other.visitedPlaces, visitedPlaces)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(places) ^
      const DeepCollectionEquality().hash(favoritePlaces) ^
      const DeepCollectionEquality().hash(visitedPlaces);

  @JsonKey(ignore: true)
  @override
  _$PlaceListStateCopyWith<_PlaceListState> get copyWith =>
      __$PlaceListStateCopyWithImpl<_PlaceListState>(this, _$identity);
}

abstract class _PlaceListState implements PlaceListState {
  const factory _PlaceListState(
      [bool isError,
      String errorMessage,
      bool isLoading,
      List<Place> places,
      List<Place> favoritePlaces,
      List<Place> visitedPlaces]) = _$_PlaceListState;

  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String get errorMessage => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  List<Place> get places => throw _privateConstructorUsedError;
  @override
  List<Place> get favoritePlaces => throw _privateConstructorUsedError;
  @override
  List<Place> get visitedPlaces => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PlaceListStateCopyWith<_PlaceListState> get copyWith =>
      throw _privateConstructorUsedError;
}
