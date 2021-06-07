import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/place_search/state.dart';
import 'package:places/data/redux/settings/state.dart';

class AppState {
  final PlaceSearchState placeSearchState;
  final PlaceListState placeListState;
  final SettingsState settingsState;

  AppState({
    required this.placeSearchState,
    required this.placeListState,
    required this.settingsState,
  });

  AppState copyWith({
    PlaceSearchState? placeSearchState,
    PlaceListState? placeListState,
    SettingsState? settingsState,
  }) {
    return AppState(
      placeSearchState: placeSearchState ?? this.placeSearchState,
      placeListState: placeListState ?? this.placeListState,
      settingsState: settingsState ?? this.settingsState,
    );
  }
}
