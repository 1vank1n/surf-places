import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/filters/reducer.dart';
import 'package:places/data/redux/place_create/actions.dart';
import 'package:places/data/redux/place_create/reducer.dart';
import 'package:places/data/redux/place_detail/actions.dart';
import 'package:places/data/redux/place_detail/reducer.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/reducer.dart';
import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/reducer.dart';
import 'package:places/data/redux/settings/actions.dart';
import 'package:places/data/redux/settings/reducer.dart';
import 'package:places/data/redux/store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is PlaceSearchAction) {
    final nextPlaceSearchState = placeSearchReducer(state.placeSearchState, action);
    return state.copyWith(placeSearchState: nextPlaceSearchState);
  }

  if (action is PlaceListAction) {
    final nextPlaceListState = placeListReducer(state.placeListState, action);
    return state.copyWith(placeListState: nextPlaceListState);
  }

  if (action is PlaceDetailAction) {
    final nextPlaceDetailState = placeDetailReducer(state.placeDetailState, action);
    return state.copyWith(placeDetailState: nextPlaceDetailState);
  }

  if (action is PlaceCreateAction) {
    final nextPlaceCreateState = placeCreateReducer(state.placeCreateState, action);
    return state.copyWith(placeCreateState: nextPlaceCreateState);
  }

  if (action is SettingsAction) {
    final nextSettingsState = settingsReducer(state.settingsState, action);
    return state.copyWith(settingsState: nextSettingsState);
  }

  if (action is FiltersAction) {
    final nextSettingsState = filtersReducer(state.filtersState, action);
    return state.copyWith(filtersState: nextSettingsState);
  }

  return state;
}
