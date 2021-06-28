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
class _$PlaceSearchStateTearOff {
  const _$PlaceSearchStateTearOff();

  _PlaceSearchState call(
      [bool isError = false,
      String errorMessage = '',
      bool isLoading = false,
      bool isShowQueriesHistory = true,
      List<String> queries = const [],
      List<Place> places = const []]) {
    return _PlaceSearchState(
      isError,
      errorMessage,
      isLoading,
      isShowQueriesHistory,
      queries,
      places,
    );
  }
}

/// @nodoc
const $PlaceSearchState = _$PlaceSearchStateTearOff();

/// @nodoc
mixin _$PlaceSearchState {
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isShowQueriesHistory => throw _privateConstructorUsedError;
  List<String> get queries => throw _privateConstructorUsedError;
  List<Place> get places => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceSearchStateCopyWith<PlaceSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceSearchStateCopyWith<$Res> {
  factory $PlaceSearchStateCopyWith(
          PlaceSearchState value, $Res Function(PlaceSearchState) then) =
      _$PlaceSearchStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      String errorMessage,
      bool isLoading,
      bool isShowQueriesHistory,
      List<String> queries,
      List<Place> places});
}

/// @nodoc
class _$PlaceSearchStateCopyWithImpl<$Res>
    implements $PlaceSearchStateCopyWith<$Res> {
  _$PlaceSearchStateCopyWithImpl(this._value, this._then);

  final PlaceSearchState _value;
  // ignore: unused_field
  final $Res Function(PlaceSearchState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
    Object? isShowQueriesHistory = freezed,
    Object? queries = freezed,
    Object? places = freezed,
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
      isShowQueriesHistory: isShowQueriesHistory == freezed
          ? _value.isShowQueriesHistory
          : isShowQueriesHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      queries: queries == freezed
          ? _value.queries
          : queries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      places: places == freezed
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc
abstract class _$PlaceSearchStateCopyWith<$Res>
    implements $PlaceSearchStateCopyWith<$Res> {
  factory _$PlaceSearchStateCopyWith(
          _PlaceSearchState value, $Res Function(_PlaceSearchState) then) =
      __$PlaceSearchStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      String errorMessage,
      bool isLoading,
      bool isShowQueriesHistory,
      List<String> queries,
      List<Place> places});
}

/// @nodoc
class __$PlaceSearchStateCopyWithImpl<$Res>
    extends _$PlaceSearchStateCopyWithImpl<$Res>
    implements _$PlaceSearchStateCopyWith<$Res> {
  __$PlaceSearchStateCopyWithImpl(
      _PlaceSearchState _value, $Res Function(_PlaceSearchState) _then)
      : super(_value, (v) => _then(v as _PlaceSearchState));

  @override
  _PlaceSearchState get _value => super._value as _PlaceSearchState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = freezed,
    Object? isShowQueriesHistory = freezed,
    Object? queries = freezed,
    Object? places = freezed,
  }) {
    return _then(_PlaceSearchState(
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
      isShowQueriesHistory == freezed
          ? _value.isShowQueriesHistory
          : isShowQueriesHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      queries == freezed
          ? _value.queries
          : queries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      places == freezed
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc

class _$_PlaceSearchState implements _PlaceSearchState {
  const _$_PlaceSearchState(
      [this.isError = false,
      this.errorMessage = '',
      this.isLoading = false,
      this.isShowQueriesHistory = true,
      this.queries = const [],
      this.places = const []]);

  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @JsonKey(defaultValue: '')
  @override
  final String errorMessage;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @JsonKey(defaultValue: true)
  @override
  final bool isShowQueriesHistory;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> queries;
  @JsonKey(defaultValue: const [])
  @override
  final List<Place> places;

  @override
  String toString() {
    return 'PlaceSearchState(isError: $isError, errorMessage: $errorMessage, isLoading: $isLoading, isShowQueriesHistory: $isShowQueriesHistory, queries: $queries, places: $places)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlaceSearchState &&
            (identical(other.isError, isError) ||
                const DeepCollectionEquality()
                    .equals(other.isError, isError)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.isShowQueriesHistory, isShowQueriesHistory) ||
                const DeepCollectionEquality().equals(
                    other.isShowQueriesHistory, isShowQueriesHistory)) &&
            (identical(other.queries, queries) ||
                const DeepCollectionEquality()
                    .equals(other.queries, queries)) &&
            (identical(other.places, places) ||
                const DeepCollectionEquality().equals(other.places, places)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(isShowQueriesHistory) ^
      const DeepCollectionEquality().hash(queries) ^
      const DeepCollectionEquality().hash(places);

  @JsonKey(ignore: true)
  @override
  _$PlaceSearchStateCopyWith<_PlaceSearchState> get copyWith =>
      __$PlaceSearchStateCopyWithImpl<_PlaceSearchState>(this, _$identity);
}

abstract class _PlaceSearchState implements PlaceSearchState {
  const factory _PlaceSearchState(
      [bool isError,
      String errorMessage,
      bool isLoading,
      bool isShowQueriesHistory,
      List<String> queries,
      List<Place> places]) = _$_PlaceSearchState;

  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String get errorMessage => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get isShowQueriesHistory => throw _privateConstructorUsedError;
  @override
  List<String> get queries => throw _privateConstructorUsedError;
  @override
  List<Place> get places => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PlaceSearchStateCopyWith<_PlaceSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
