import 'package:places/data/model/filter_category.dart';
import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/filters/states.dart';
import 'package:redux/redux.dart';

final filtersReducer = combineReducers<FiltersState>([
  TypedReducer<FiltersState, SetStateFiltersAction>(_setState),
  TypedReducer<FiltersState, LoadFiltersAction>(_loadFilter),
  TypedReducer<FiltersState, UpdateFiltersAction>(_updateFilter),
  TypedReducer<FiltersState, ShowFiltersAction>(_showFilter),
  TypedReducer<FiltersState, ErrorFiltersAction>(_showError),
]);

FiltersState _setState(
  FiltersState state,
  SetStateFiltersAction action,
) =>
    action.state;

FiltersState _loadFilter(
  FiltersState state,
  LoadFiltersAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

FiltersState _updateFilter(
  FiltersState state,
  UpdateFiltersAction action,
) {
  final Set<FilterCategory> filteredTypes = state.filteredTypes.toSet();
  if (action.filterCategory != null) {
    if (filteredTypes.contains(action.filterCategory)) {
      filteredTypes.remove(action.filterCategory);
    } else {
      filteredTypes.add(action.filterCategory!);
    }
  }

  return state.copyWith(
    startRange: action.startRange,
    endRange: action.endRange,
    filteredTypes: filteredTypes,
  );
}

FiltersState _showFilter(
  FiltersState state,
  ShowFiltersAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      count: action.count,
    );

FiltersState _showError(
  FiltersState state,
  ErrorFiltersAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );
