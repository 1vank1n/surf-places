import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/data/repository/settings_repository.dart';
import 'package:redux/redux.dart';

class PlaceListMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;

  PlaceListMiddleware({required this.placeRepository});

  @override
  call(Store<AppState> store, action, next) async {
    if (action is LoadPlaceListAction) {
      final PlacesFilterRequestDto filter = await SettingsRepository().getPlacesFilter();

      try {
        placeRepository.postFilteredPlaces(filter).then(
          (List<Place> places) {
            store.dispatch(ShowPlaceListAction(places: places));
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

        store.dispatch(ErrorPlaceListAction(message: message));
      }
    }

    next(action);
  }
}
