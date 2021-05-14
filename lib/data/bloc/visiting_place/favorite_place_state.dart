import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовое состояние
abstract class FavoritePlaceState extends Equatable {
  const FavoritePlaceState();

  @override
  List<Object> get props => [];
}

/// Загрукзка избранного
class LoadingFavoritePlacesState extends FavoritePlaceState {}

/// Отображение избранного
class LoadedFavoritePlacesState extends FavoritePlaceState {
  final List<Place> favoritePlaces;

  const LoadedFavoritePlacesState({
    required this.favoritePlaces,
  });

  @override
  List<Object> get props => [favoritePlaces];

  @override
  String toString() => 'LoadedFavoritePlacesState { favoritePlaces: $favoritePlaces }';
}
