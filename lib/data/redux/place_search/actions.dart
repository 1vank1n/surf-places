import 'package:places/data/model/place.dart';

abstract class PlaceSearchAction {}

/// Показать историю запросов
class ShowHistoryPlaceSearchAction extends PlaceSearchAction {}

/// Начать поиск по запросу
class SearchPlaceSearchAction extends PlaceSearchAction {
  final String query;

  SearchPlaceSearchAction(this.query);
}

/// Отобразить загруженные места
class ShowPlacesPlaceSearchAction extends PlaceSearchAction {
  final List<Place> places;

  ShowPlacesPlaceSearchAction(this.places);
}

/// Отобразить ошибку поиска
class ErrorPlaceSearchAction extends PlaceSearchAction {
  final String message;

  ErrorPlaceSearchAction(this.message);
}

/// Добавить запрос в истории
class AddQueryToHistoryPlaceSearchAction extends PlaceSearchAction {
  final String query;

  AddQueryToHistoryPlaceSearchAction(this.query);
}

/// Удалить запрос из истории
class RemoveQueryFromHistoryPlaceSearchAction extends PlaceSearchAction {
  final String query;

  RemoveQueryFromHistoryPlaceSearchAction(this.query);
}

/// Очистить историю запросов
class ClearQueryHistoryPlaceSearchAction extends PlaceSearchAction {}
