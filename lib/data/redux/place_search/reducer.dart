import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/states.dart';
import 'package:redux/redux.dart';

final placeSearchReducer = combineReducers<PlaceSearchState>([
  TypedReducer<PlaceSearchState, ShowQueryHistoryAction>(_showQueryHistory),
  TypedReducer<PlaceSearchState, ShowSearchedPlacesAction>(_showSearchedPlaces),
  TypedReducer<PlaceSearchState, AddQueryToHistoryAction>(_addQueryToHistoryReducer),
  TypedReducer<PlaceSearchState, RemoveQueryFromHistoryAction>(_removeQueryFromHistoryReducer),
  TypedReducer<PlaceSearchState, ClearQueryHistoryAction>(_clearQueryHistoryReducer),
]);

PlaceSearchState _showQueryHistory(
  PlaceSearchState state,
  ShowQueryHistoryAction action,
) =>
    state.copyWith(isShowQueriesHistory: true);

PlaceSearchState _showSearchedPlaces(
  PlaceSearchState state,
  ShowSearchedPlacesAction action,
) =>
    state.copyWith(
      isShowQueriesHistory: false,
      places: action.places,
    );

PlaceSearchState _addQueryToHistoryReducer(
  PlaceSearchState state,
  AddQueryToHistoryAction action,
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
  RemoveQueryFromHistoryAction action,
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
  ClearQueryHistoryAction action,
) =>
    state.copyWith(queries: []);
