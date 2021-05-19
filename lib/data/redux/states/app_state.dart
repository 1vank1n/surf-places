import 'package:places/data/redux/states/searched_place_state.dart';

class AppState {
  final SearchedPlacesState searchedPlacesState;
  final List<String> queries;

  AppState({
    SearchedPlacesState? searchedPlacesState,
    this.queries = const [],
  }) : this.searchedPlacesState = searchedPlacesState ?? SearchedPlacesInitialState();

  AppState cloneWith({
    SearchedPlacesState? searchedPlacesState,
    List<String>? queries,
  }) =>
      AppState(
        searchedPlacesState: searchedPlacesState ?? this.searchedPlacesState,
        queries: queries ?? this.queries,
      );
}
