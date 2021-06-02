import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:redux/redux.dart';

final placeListReducer = combineReducers<PlaceListState>([
  TypedReducer<PlaceListState, LoadPlaceListAction>(_loadPlaces),
  TypedReducer<PlaceListState, ShowPlaceListAction>(_showPlaces),
  TypedReducer<PlaceListState, ErrorPlaceListAction>(_showError),
]);

PlaceListState _loadPlaces(
  PlaceListState state,
  LoadPlaceListAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

PlaceListState _showPlaces(
  PlaceListState state,
  ShowPlaceListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      places: action.places,
    );

PlaceListState _showError(
  PlaceListState state,
  ErrorPlaceListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );
