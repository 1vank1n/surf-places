import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/actions/place_search_actions.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:redux/redux.dart';

class PlaceSearchMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;

  PlaceSearchMiddleware({required this.placeRepository});

  @override
  call(Store<AppState> store, action, next) {
    if (action is SearchPlacesAction) {
      var _filter = PlacesFilterRequestDto(nameFilter: action.query);
      store.dispatch(AddQueryToHistoryAction(action.query));

      try {
        placeRepository.postFilteredPlaces(_filter).then(
              (List<Place> places) => store.dispatch(
                ShowSearchedPlacesAction(places),
              ),
            );
      } on DioError catch (err) {
        String message;

        try {
          NetworkException networkException = err.error as NetworkException;
          message = networkException.toString();
        } on TypeError {
          message = 'Что-то пошло не так попробуйте позже';
        }

        store.dispatch(ShowSearchErrorAction(message));
      }
    }

    next(action);
  }
}
