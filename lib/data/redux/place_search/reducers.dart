import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/states.dart';
import 'package:redux/redux.dart';

final placeSearchReducer = combineReducers<PlaceSearchState>([
  TypedReducer<PlaceSearchState, ShowHistoryPlaceSearchAction>(_showQueryHistory),
  TypedReducer<PlaceSearchState, ShowPlacesPlaceSearchAction>(_showSearchedPlaces),
  TypedReducer<PlaceSearchState, AddQueryToHistoryPlaceSearchAction>(_addQueryToHistoryReducer),
  TypedReducer<PlaceSearchState, RemoveQueryFromHistoryPlaceSearchAction>(
      _removeQueryFromHistoryReducer),
  TypedReducer<PlaceSearchState, ClearQueryHistoryPlaceSearchAction>(_clearQueryHistoryReducer),
  TypedReducer<PlaceSearchState, ShowQueryHistoryPlaceSearchAction>(_showQueryHistoryReducer),
]);

PlaceSearchState _showQueryHistory(
  PlaceSearchState state,
  ShowHistoryPlaceSearchAction action,
) =>
    state.copyWith(isShowQueriesHistory: true);

PlaceSearchState _showSearchedPlaces(
  PlaceSearchState state,
  ShowPlacesPlaceSearchAction action,
) =>
    state.copyWith(
      isShowQueriesHistory: false,
      places: action.places,
    );

PlaceSearchState _addQueryToHistoryReducer(
  PlaceSearchState state,
  AddQueryToHistoryPlaceSearchAction action,
) {
  List<String> queries = state.queries.toList();
  String query = action.query;

  if (query != '') {
    if (!queries.contains(query)) {
      queries.add(query);
    } else {
      queries.remove(query);
      queries.insert(0, query);
    }
  }

  return state.copyWith(queries: queries);
}

PlaceSearchState _removeQueryFromHistoryReducer(
  PlaceSearchState state,
  RemoveQueryFromHistoryPlaceSearchAction action,
) {
  List<String> queries = state.queries.toList();
  String query = action.query;

  if (queries.contains(query)) {
    queries.remove(query);
  }

  return state.copyWith(queries: queries);
}

PlaceSearchState _clearQueryHistoryReducer(
  PlaceSearchState state,
  ClearQueryHistoryPlaceSearchAction action,
) =>
    state.copyWith(queries: []);

PlaceSearchState _showQueryHistoryReducer(
  PlaceSearchState state,
  ShowQueryHistoryPlaceSearchAction action,
) =>
    state.copyWith(queries: action.queries);
