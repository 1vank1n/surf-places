import 'package:places/data/redux/filters/state.dart';
import 'package:places/data/redux/place_create/state.dart';
import 'package:places/data/redux/place_detail/state.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/place_search/state.dart';
import 'package:places/data/redux/settings/state.dart';

class AppState {
  final PlaceSearchState placeSearchState;
  final PlaceListState placeListState;
  final PlaceDetailState placeDetailState;
  final PlaceCreateState placeCreateState;
  final SettingsState settingsState;
  final FiltersState filtersState;

  AppState({
    required this.placeSearchState,
    required this.placeListState,
    required this.placeDetailState,
    required this.placeCreateState,
    required this.settingsState,
    required this.filtersState,
  });

  AppState copyWith({
    PlaceSearchState? placeSearchState,
    PlaceListState? placeListState,
    PlaceDetailState? placeDetailState,
    PlaceCreateState? placeCreateState,
    SettingsState? settingsState,
    FiltersState? filtersState,
  }) {
    return AppState(
      placeSearchState: placeSearchState ?? this.placeSearchState,
      placeListState: placeListState ?? this.placeListState,
      placeDetailState: placeDetailState ?? this.placeDetailState,
      placeCreateState: placeCreateState ?? this.placeCreateState,
      settingsState: settingsState ?? this.settingsState,
      filtersState: filtersState ?? this.filtersState,
    );
  }
}
