import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/filters/state.dart';
import 'package:redux/redux.dart';

final filtersReducer = combineReducers<FiltersState>([
  TypedReducer<FiltersState, LoadFiltersAction>(_loadPlace),
  TypedReducer<FiltersState, ShowFiltersAction>(_showPlace),
  TypedReducer<FiltersState, ErrorFiltersAction>(_showError),
]);

FiltersState _loadPlace(
  FiltersState state,
  LoadFiltersAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

FiltersState _showPlace(
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
