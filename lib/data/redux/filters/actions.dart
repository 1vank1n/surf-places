import 'package:places/data/model/places_filter_request_dto.dart';

abstract class FiltersAction {}

class LoadFiltersAction extends FiltersAction {
  final PlacesFilterRequestDto filter;

  LoadFiltersAction({required this.filter});
}

class ShowFiltersAction extends FiltersAction {
  final int count;

  ShowFiltersAction({required this.count});
}

class ErrorFiltersAction extends FiltersAction {
  final String message;

  ErrorFiltersAction({required this.message});
}
