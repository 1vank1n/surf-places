import 'package:dio/dio.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/ui/screen/res/constants.dart';
import 'package:redux/redux.dart';

class FiltersMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;

  FiltersMiddleware({required this.placeRepository});

  @override
  call(Store<AppState> store, action, next) {
    if (action is LoadFiltersAction) {
      try {
        placeRepository.postFilteredPlaces(action.filter).then(
          (places) {
            final filteredPlaces = places
                .where(
                  (place) => place.isPointInRangeAtUserPoint(
                    userLat: USER_LAT,
                    userLng: USER_LNG,
                    startRange: store.state.filtersState.startRange,
                    endRange: store.state.filtersState.endRange,
                  ),
                )
                .toList();

            store.dispatch(ShowFiltersAction(count: filteredPlaces.length));
          },
        );
      } on DioError catch (err) {
        String message;

        try {
          NetworkException networkException = err.error as NetworkException;
          message = networkException.toString();
        } on TypeError {
          message = 'Что-то пошло не так попробуйте позже';
        }

        store.dispatch(ErrorFiltersAction(message: message));
      }
    }

    next(action);
  }
}
