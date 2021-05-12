import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое событие
abstract class VisitingPlaceEvent extends Equatable {
  const VisitingPlaceEvent();

  @override
  List<Object> get props => [];
}

/// Показать таб с избранными местами
class ShowFavoritePlacesEvent extends VisitingPlaceEvent {}

/// Показать таб с посещёнными местами
class ShowVisitedPlacesEvent extends VisitingPlaceEvent {}

/// Удаление места из избранных
class RemoveFromFavoritePlacesEvent extends VisitingPlaceEvent {
  final Place place;

  const RemoveFromFavoritePlacesEvent(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'RemoveFromFavoritePlacesEvent { place: $place }';
}

/// Удаление места из посещённых
class RemoveFromVisitedPlacesEvent extends VisitingPlaceEvent {
  final Place place;

  const RemoveFromVisitedPlacesEvent(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'RemoveFromVisitedPlacesEvent { place: $place }';
}
