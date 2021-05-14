import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое событие
abstract class FavoritePlaceEvent extends Equatable {
  const FavoritePlaceEvent();

  @override
  List<Object> get props => [];
}

/// Загрузка избранного
class LoadFavoritePlacesEvent extends FavoritePlaceEvent {}

/// Удаление места из избранных
class RemoveFromFavoritePlacesEvent extends FavoritePlaceEvent {
  final Place place;

  const RemoveFromFavoritePlacesEvent(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'RemoveFromFavoritePlacesEvent { place: $place }';
}
