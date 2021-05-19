import 'package:places/data/redux/actions/place_search_actions.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:places/data/redux/states/searched_place_state.dart';
import 'package:redux/redux.dart';

final placeSearchReducer = combineReducers<AppState>([
  TypedReducer<AppState, ShowQueryHistoryAction>(_showQueryHistory),
  TypedReducer<AppState, ShowSearchedPlacesAction>(_showSearchedPlaces),
  TypedReducer<AppState, AddQueryToHistoryAction>(_addQueryToHistoryReducer),
  TypedReducer<AppState, RemoveQueryFromHistoryAction>(_removeQueryFromHistoryReducer),
  TypedReducer<AppState, ClearQueryHistoryAction>(_clearQueryHistoryReducer),
]);

AppState _showQueryHistory(
  AppState state,
  ShowQueryHistoryAction action,
) =>
    state.cloneWith(searchedPlacesState: SearchedPlacesInitialState());

AppState _showSearchedPlaces(
  AppState state,
  ShowSearchedPlacesAction action,
) =>
    state.cloneWith(searchedPlacesState: SearchedPlacesDataState(action.places));

AppState _addQueryToHistoryReducer(
  AppState state,
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

  return state.cloneWith(queries: queries);
}

AppState _removeQueryFromHistoryReducer(
  AppState state,
  RemoveQueryFromHistoryAction action,
) {
  List<String> queries = state.queries.toList();
  String query = action.query;

  if (queries.contains(query)) {
    queries.remove(query);
  }

  return state.cloneWith(queries: queries);
}

AppState _clearQueryHistoryReducer(
  AppState state,
  ClearQueryHistoryAction action,
) =>
    state.cloneWith(queries: []);
