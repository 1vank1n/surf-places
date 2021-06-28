import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/states.dart';
import 'package:redux/redux.dart';

final placeListReducer = combineReducers<PlaceListState>([
  TypedReducer<PlaceListState, LoadPlaceListAction>(_loadPlaces),
  TypedReducer<PlaceListState, ShowPlaceListAction>(_showPlaces),
  TypedReducer<PlaceListState, ErrorPlaceListAction>(_showError),
  TypedReducer<PlaceListState, AddPlaceToFavoritesPlaceListAction>(_addToFavorites),
  TypedReducer<PlaceListState, RemovePlaceFromFavoritesPlaceListAction>(_removeFromFavorites),
  TypedReducer<PlaceListState, AddPlaceToVisitedPlaceListAction>(_addToVisited),
  TypedReducer<PlaceListState, RemovePlaceFromVisitedPlaceListAction>(_removeFromVisited),
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

PlaceListState _addToFavorites(
  PlaceListState state,
  AddPlaceToFavoritesPlaceListAction action,
) {
  final favoritePlaces = state.favoritePlaces.toList();
  if (!favoritePlaces.contains(action.place)) {
    favoritePlaces.add(action.place);
  }

  return state.copyWith(
    isLoading: false,
    isError: false,
    favoritePlaces: favoritePlaces,
  );
}

PlaceListState _removeFromFavorites(
  PlaceListState state,
  RemovePlaceFromFavoritesPlaceListAction action,
) {
  final favoritePlaces = state.favoritePlaces.toList();
  if (favoritePlaces.contains(action.place)) {
    favoritePlaces.remove(action.place);
  }

  return state.copyWith(
    isLoading: false,
    isError: false,
    favoritePlaces: favoritePlaces,
  );
}

PlaceListState _addToVisited(
  PlaceListState state,
  AddPlaceToVisitedPlaceListAction action,
) {
  final visitedPlaces = state.visitedPlaces.toList();
  if (!visitedPlaces.contains(action.place)) {
    visitedPlaces.add(action.place);
  }

  return state.copyWith(
    isLoading: false,
    isError: false,
    visitedPlaces: visitedPlaces,
  );
}

PlaceListState _removeFromVisited(
  PlaceListState state,
  RemovePlaceFromVisitedPlaceListAction action,
) {
  final visitedPlaces = state.visitedPlaces.toList();
  if (visitedPlaces.contains(action.place)) {
    visitedPlaces.remove(action.place);
  }

  return state.copyWith(
    isLoading: false,
    isError: false,
    visitedPlaces: visitedPlaces,
  );
}
