import 'package:dio/dio.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/place_detail/actions.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:redux/redux.dart';

class PlaceDetailMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;

  PlaceDetailMiddleware({required this.placeRepository});

  @override
  call(Store<AppState> store, action, next) {
    if (action is LoadPlaceDetailAction) {
      try {
        placeRepository.getPlace(action.placeId).then(
          (place) {
            if (place != null) {
              store.dispatch(ShowPlaceDetailAction(place: place));
            } else {
              final message = 'Ошибка при загрузке';
              store.dispatch(ErrorPlaceDetailAction(message: message));
            }
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

        store.dispatch(ErrorPlaceDetailAction(message: message));
      }
    }

    next(action);
  }
}
