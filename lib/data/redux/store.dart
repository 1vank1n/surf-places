import 'package:places/data/redux/place_detail/state.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/place_search/state.dart';
import 'package:places/data/redux/settings/state.dart';

class AppState {
  final PlaceSearchState placeSearchState;
  final PlaceListState placeListState;
  final PlaceDetailState placeDetailState;
  final SettingsState settingsState;

  AppState({
    required this.placeSearchState,
    required this.placeListState,
    required this.placeDetailState,
    required this.settingsState,
  });

  AppState copyWith({
    PlaceSearchState? placeSearchState,
    PlaceListState? placeListState,
    PlaceDetailState? placeDetailState,
    SettingsState? settingsState,
  }) {
    return AppState(
      placeSearchState: placeSearchState ?? this.placeSearchState,
      placeListState: placeListState ?? this.placeListState,
      placeDetailState: placeDetailState ?? this.placeDetailState,
      settingsState: settingsState ?? this.settingsState,
    );
  }
}
