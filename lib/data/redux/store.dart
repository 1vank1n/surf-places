import 'package:places/data/redux/place_search/states.dart';

class AppState {
  final PlaceSearchState placeSearchState;

  AppState({
    required this.placeSearchState,
  });

  AppState copyWith({
    PlaceSearchState? placeSearchState,
  }) {
    return AppState(
      placeSearchState: placeSearchState ?? PlaceSearchState.initial(),
    );
  }
}
