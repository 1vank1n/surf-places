// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceStore on PlaceStoreBase, Store {
  final _$PlaceStoreBaseActionController =
      ActionController(name: 'PlaceStoreBase');

  @override
  Future<List<Place>> getPlaces(double radius, String category) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.getPlaces');
    try {
      return super.getPlaces(radius, category);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Place?> getPlaceDetails(int id) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.getPlaceDetails');
    try {
      return super.getPlaceDetails(id);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<Place> getFavoritesPlaces() {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.getFavoritesPlaces');
    try {
      return super.getFavoritesPlaces();
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFavorites(Place place) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.addToFavorites');
    try {
      return super.addToFavorites(place);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromFavorites(Place place) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.removeFromFavorites');
    try {
      return super.removeFromFavorites(place);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
