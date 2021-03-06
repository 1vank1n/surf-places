import 'package:places/data/model/filter_category.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/redux/filters/state.dart';

abstract class FiltersAction {}

class SetStateFiltersAction extends FiltersAction {
  final FiltersState state;

  SetStateFiltersAction({required this.state});
}

class LoadFiltersAction extends FiltersAction {
  final PlacesFilterRequestDto filter;

  LoadFiltersAction({required this.filter});
}

class UpdateFiltersAction extends FiltersAction {
  final double? startRange;
  final double? endRange;
  final FilterCategory? filterCategory;

  UpdateFiltersAction({
    this.startRange,
    this.endRange,
    this.filterCategory,
  });
}

class ShowFiltersAction extends FiltersAction {
  final int count;

  ShowFiltersAction({required this.count});
}

class ErrorFiltersAction extends FiltersAction {
  final String message;

  ErrorFiltersAction({required this.message});
}
