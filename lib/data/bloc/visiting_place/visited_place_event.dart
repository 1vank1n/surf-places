import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое событие
abstract class VisitedPlaceEvent extends Equatable {
  const VisitedPlaceEvent();

  @override
  List<Object> get props => [];
}

/// Загрузка посещённых мест
class LoadVisitedPlacesEvent extends VisitedPlaceEvent {}

/// Удаление места из посещённых
class RemoveFromVisitedPlacesEvent extends VisitedPlaceEvent {
  final Place place;

  const RemoveFromVisitedPlacesEvent(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'RemoveFromVisitedPlacesEvent { place: $place }';
}
