import 'package:dio/dio.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:redux/redux.dart';

class PlaceSearchMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository placeRepository;
  final AppDB appDB;

  PlaceSearchMiddleware({
    required this.placeRepository,
    required this.appDB,
  });

  @override
  call(Store<AppState> store, action, next) async {
    if (action is SearchPlaceSearchAction) {
      var _filter = PlacesFilterRequestDto(nameFilter: action.query);

      List<SearchRequest> searchRequests = await appDB.allSearchRequestEntities;
      if (searchRequests.where((sr) => sr.title == action.query).length == 0) {
        await appDB.saveSearchRequest(SearchRequestsCompanion.insert(title: action.query));
      }
      await dispatchShowQueryHistoryPlaceSearchAction(store);

      try {
        List<Place> places = await placeRepository.postFilteredPlaces(_filter);
        ShowPlacesPlaceSearchAction(places);
      } on DioError catch (err) {
        String message;

        try {
          NetworkException networkException = err.error as NetworkException;
          message = networkException.toString();
        } on TypeError {
          message = 'Что-то пошло не так попробуйте позже';
        }

        store.dispatch(ErrorPlaceSearchAction(message));
      }
    } else if (action is RemoveQueryFromHistoryPlaceSearchAction) {
      List<SearchRequest> searchRequests = await appDB.allSearchRequestEntities;
      int index = searchRequests.indexWhere((sr) => sr.title == action.query);
      if (index >= 0) {
        await appDB.deleteSearchRequest(searchRequests[index].id);
      }
      await dispatchShowQueryHistoryPlaceSearchAction(store);
    } else if (action is ClearQueryHistoryPlaceSearchAction) {
      await appDB.clearSearchRequest();
      await dispatchShowQueryHistoryPlaceSearchAction(store);
    }

    next(action);
  }

  Future<void> dispatchShowQueryHistoryPlaceSearchAction(Store<AppState> store) async {
    List<String> queries = await appDB.allSearchRequestStrings();
    store.dispatch(ShowQueryHistoryPlaceSearchAction(queries));
  }
}
