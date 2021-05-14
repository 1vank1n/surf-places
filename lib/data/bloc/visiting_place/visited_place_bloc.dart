import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/bloc/visiting_place/visited_place_event.dart';
import 'package:places/data/bloc/visiting_place/visited_place_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_respository.dart';

class VisitedPlaceBloc extends Bloc<VisitedPlaceEvent, VisitedPlaceState> {
  final PlaceRepository placeRepository;

  VisitedPlaceBloc({
    required this.placeRepository,
  }) : super(LoadingVisitedPlacesState());

  @override
  Stream<VisitedPlaceState> mapEventToState(VisitedPlaceEvent event) async* {
    if (event is LoadVisitedPlacesEvent) {
      yield* _mapLoadVisitedPlacesEvent();
    } else if (event is RemoveFromVisitedPlacesEvent) {
      yield* _removePlaceFromVisitedPlaces(event);
    }
  }

  Stream<VisitedPlaceState> _mapLoadVisitedPlacesEvent() async* {
    List<Place> visitedPlaces = await placeRepository.getVisitedPlaces();
    yield LoadedVisitedPlacesState(visitedPlaces: visitedPlaces);
  }

  Stream<VisitedPlaceState> _removePlaceFromVisitedPlaces(
      RemoveFromVisitedPlacesEvent event) async* {
    placeRepository.removeFromVisited(event.place);
    yield* _mapLoadVisitedPlacesEvent();
  }
}
