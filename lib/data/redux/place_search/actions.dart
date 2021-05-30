import 'package:places/data/model/place.dart';

abstract class PlaceSearchAction {}

/// Показать историю запросов
class ShowQueryHistoryAction extends PlaceSearchAction {}

/// Начать поиск по запросу
class SearchPlacesAction extends PlaceSearchAction {
  final String query;

  SearchPlacesAction(this.query);
}

/// Отобразить загруженные места
class ShowSearchedPlacesAction extends PlaceSearchAction {
  final List<Place> places;

  ShowSearchedPlacesAction(this.places);
}

/// Отобразить ошибку поиска
class ShowSearchErrorAction extends PlaceSearchAction {
  final String message;

  ShowSearchErrorAction(this.message);
}

/// Добавить запрос в истории
class AddQueryToHistoryAction extends PlaceSearchAction {
  final String query;

  AddQueryToHistoryAction(this.query);
}

/// Удалить запрос из истории
class RemoveQueryFromHistoryAction extends PlaceSearchAction {
  final String query;

  RemoveQueryFromHistoryAction(this.query);
}

/// Очистить историю запросов
class ClearQueryHistoryAction extends PlaceSearchAction {}
