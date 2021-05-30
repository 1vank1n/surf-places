import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/reducer.dart';
import 'package:places/data/redux/store.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is PlaceSearchAction) {
    final nextPlaceSearchState = placeSearchReducer(state.placeSearchState, action);
    return state.copyWith(placeSearchState: nextPlaceSearchState);
  }

  return state;
}
