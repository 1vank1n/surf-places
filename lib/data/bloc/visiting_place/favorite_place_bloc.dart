import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/bloc/visiting_place/favorite_place_event.dart';
import 'package:places/data/bloc/visiting_place/favorite_place_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_respository.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceRepository placeRepository;

  FavoritePlaceBloc({
    required this.placeRepository,
  }) : super(LoadingFavoritePlacesState());

  @override
  Stream<FavoritePlaceState> mapEventToState(FavoritePlaceEvent event) async* {
    if (event is LoadFavoritePlacesEvent) {
      yield* _mapLoadFavoritePlacesEvent();
    } else if (event is RemoveFromFavoritePlacesEvent) {
      yield* _removePlaceFromFavoritePlaces(event);
    }
  }

  Stream<FavoritePlaceState> _mapLoadFavoritePlacesEvent() async* {
    List<Place> favoritePlaces = await placeRepository.getFavoritePlaces();
    yield LoadedFavoritePlacesState(favoritePlaces: favoritePlaces);
  }

  Stream<FavoritePlaceState> _removePlaceFromFavoritePlaces(
      RemoveFromFavoritePlacesEvent event) async* {
    placeRepository.removeFromFavorites(event.place);
    yield LoadingFavoritePlacesState();
    yield* _mapLoadFavoritePlacesEvent();
  }
}
