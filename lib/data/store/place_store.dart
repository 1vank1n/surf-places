import 'package:mobx/mobx.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

part 'place_store.g.dart';

class PlaceStore = PlaceStoreBase with _$PlaceStore;

abstract class PlaceStoreBase with Store {
  final PlaceRepository placeRepository;

  PlaceStoreBase({required this.placeRepository});

  @observable
  List<Place> _favoritePlaces = [];

  @action
  Future<List<Place>> getPlaces(double radius, String category) {
    final Map<String, double> userCoordinates = {
      'lat': 60.0,
      'lng': 30.0,
    };

    PlacesFilterRequestDto _filter = PlacesFilterRequestDto.withCoords(
      lat: userCoordinates['lat'],
      lng: userCoordinates['lng'],
      radius: radius,
    );

    return placeRepository.postFilteredPlaces(_filter);
  }

  @action
  Future<Place?> getPlaceDetails(int id) {
    return placeRepository.getPlace(id);
  }

  @action
  List<Place> getFavoritesPlaces() {
    return _favoritePlaces;
  }

  @action
  void addToFavorites(Place place) {
    if (!_favoritePlaces.contains(place)) {
      _favoritePlaces.add(place);
    }
  }

  @action
  void removeFromFavorites(Place place) {
    if (_favoritePlaces.contains(place)) {
      _favoritePlaces.remove(place);
    }
  }
}
