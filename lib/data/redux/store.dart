import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/place_search/state.dart';

class AppState {
  final PlaceSearchState placeSearchState;
  final PlaceListState placeListState;

  AppState({
    required this.placeSearchState,
    required this.placeListState,
  });

  AppState copyWith({
    PlaceSearchState? placeSearchState,
    PlaceListState? placeListState,
  }) {
    return AppState(
      placeSearchState: placeSearchState ?? PlaceSearchState.initial(),
      placeListState: placeListState ?? PlaceListState.initial(),
    );
  }
}
