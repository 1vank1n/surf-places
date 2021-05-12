import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое состояние
abstract class VisitingPlaceState extends Equatable {
  const VisitingPlaceState();

  @override
  List<Object> get props => [];
}

/// Состояние: Отображение мест добавленных в избранное
class FavoritePlacesState extends VisitingPlaceState {
  final List<Place> favoritePlaces;

  FavoritePlacesState({required this.favoritePlaces});

  @override
  List<Object> get props => [favoritePlaces];

  @override
  String toString() => 'FavoritesPlacesState';
}

/// Состояние: Отображение посещённых мест
class VisitedPlacesState extends VisitingPlaceState {
  final List<Place> visitedPlaces;

  VisitedPlacesState({required this.visitedPlaces});

  @override
  List<Object> get props => [visitedPlaces];

  @override
  String toString() => 'VisitedPlacesState';
}
