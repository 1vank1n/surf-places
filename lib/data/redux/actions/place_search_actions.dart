import 'package:places/data/model/place.dart';

/// Показать историю запросов
class ShowQueryHistoryAction {}

/// Добавить запрос в истории
class AddQueryToHistoryAction {
  final String query;

  const AddQueryToHistoryAction(this.query);
}

/// Удалить запрос из истории
class RemoveQueryFromHistoryAction {
  final String query;

  const RemoveQueryFromHistoryAction(this.query);
}

/// Очистить историю запросов
class ClearQueryHistoryAction {}

/// Начать поиск по запросу
class SearchPlacesAction {
  final String query;

  const SearchPlacesAction(this.query);
}

/// Отобразить загруженные места
class ShowSearchedPlacesAction {
  final List<Place> places;

  const ShowSearchedPlacesAction(this.places);
}

/// Отобразить ошибку поиска
class ShowSearchErrorAction {
  final String message;

  ShowSearchErrorAction(this.message);
}
