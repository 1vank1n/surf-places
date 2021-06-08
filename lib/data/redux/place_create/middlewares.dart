import 'package:dio/dio.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/place_create/actions.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:redux/redux.dart';

class PlaceCreateMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;

  PlaceCreateMiddleware({required this.placeRepository});

  @override
  call(Store<AppState> store, action, next) {
    if (action is UploadPlaceCreateAction) {
      try {
        placeRepository.postPlace(action.place).then(
          (place) {
            if (place != null) {
              store.dispatch(SuccessUploadPlaceCreateAction(place: place));
            } else {
              final message = 'Ошибка при загрузке';
              store.dispatch(ErrorPlaceCreateAction(message: message));
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

        store.dispatch(ErrorPlaceCreateAction(message: message));
      }
    }

    next(action);
  }
}
