import 'package:places/data/redux/place_detail/actions.dart';
import 'package:places/data/redux/place_detail/states.dart';
import 'package:redux/redux.dart';

final placeDetailReducer = combineReducers<PlaceDetailState>([
  TypedReducer<PlaceDetailState, LoadPlaceDetailAction>(_loadPlace),
  TypedReducer<PlaceDetailState, ShowPlaceDetailAction>(_showPlace),
  TypedReducer<PlaceDetailState, ErrorPlaceDetailAction>(_showError),
]);

PlaceDetailState _loadPlace(
  PlaceDetailState state,
  LoadPlaceDetailAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

PlaceDetailState _showPlace(
  PlaceDetailState state,
  ShowPlaceDetailAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      place: action.place,
    );

PlaceDetailState _showError(
  PlaceDetailState state,
  ErrorPlaceDetailAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );
