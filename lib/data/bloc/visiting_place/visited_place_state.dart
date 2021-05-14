import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое состояние
abstract class VisitedPlaceState extends Equatable {
  const VisitedPlaceState();

  @override
  List<Object> get props => [];
}

/// Загрукзка посещённых мест
class LoadingVisitedPlacesState extends VisitedPlaceState {}

/// Отображение посещённых мест
class LoadedVisitedPlacesState extends VisitedPlaceState {
  final List<Place> visitedPlaces;

  const LoadedVisitedPlacesState({
    required this.visitedPlaces,
  });

  @override
  List<Object> get props => [visitedPlaces];

  @override
  String toString() => 'LoadedVisitedPlacesState { visitedPlaces: $visitedPlaces }';
}
