import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/reducer.dart';
import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/reducer.dart';
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

  return state;
}
