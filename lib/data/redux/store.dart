import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/redux/filters/states.dart';
import 'package:places/data/redux/place_create/states.dart';
import 'package:places/data/redux/place_detail/states.dart';
import 'package:places/data/redux/place_list/states.dart';
import 'package:places/data/redux/place_search/states.dart';
import 'package:places/data/redux/settings/states.dart';

part 'store.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
    PlaceSearchState placeSearchState,
    PlaceListState placeListState,
    PlaceDetailState placeDetailState,
    PlaceCreateState placeCreateState,
    SettingsState settingsState,
    FiltersState filtersState,
  ) = _AppState;
}
