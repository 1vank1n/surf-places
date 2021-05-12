import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/bloc/visiting_place/visiting_place_event.dart';
import 'package:places/data/bloc/visiting_place/visiting_place_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/data/storage/place_storage.dart';

class VisitingPlaceBloc extends Bloc<VisitingPlaceEvent, VisitingPlaceState> {
  final PlaceRepository placeRepository;
  final PlaceStorage placeStorage;

  VisitingPlaceBloc({
    required this.placeRepository,
    required this.placeStorage,
  }) : super(FavoritePlacesState(favoritePlaces: placeStorage.getFavoritePlaces()));

  @override
  Stream<VisitingPlaceState> mapEventToState(VisitingPlaceEvent event) async* {
    if (event is ShowFavoritePlacesEvent) {
      yield* _showFavoritePlaces();
    } else if (event is ShowVisitedPlacesEvent) {
      yield* _showVisitedPlaces();
    } else if (event is RemoveFromFavoritePlacesEvent) {
      yield* _removePlaceFromFavoritePlaces(event);
    } else if (event is RemoveFromVisitedPlacesEvent) {
      yield* _removePlaceFromVisitedPlaces(event);
    }
  }

  Stream<VisitingPlaceState> _showFavoritePlaces() async* {
    List<Place> favoritePlaces = placeStorage.getFavoritePlaces();
    yield FavoritePlacesState(favoritePlaces: favoritePlaces);
  }

  Stream<VisitingPlaceState> _showVisitedPlaces() async* {
    var visitedPlaces = placeStorage.getVisitedPlaces();
    yield VisitedPlacesState(visitedPlaces: visitedPlaces);
  }

  Stream<VisitingPlaceState> _removePlaceFromFavoritePlaces(
      RemoveFromFavoritePlacesEvent event) async* {
    placeStorage.removeFromFavorites(event.place);
    List<Place> favoritePlaces = placeStorage.getFavoritePlaces();
    yield FavoritePlacesState(favoritePlaces: favoritePlaces);
  }

  Stream<VisitingPlaceState> _removePlaceFromVisitedPlaces(
      RemoveFromVisitedPlacesEvent event) async* {
    placeStorage.removeFromVisited(event.place);
    List<Place> visitedPlaces = placeStorage.getVisitedPlaces();
    yield VisitedPlacesState(visitedPlaces: visitedPlaces);
  }
}
