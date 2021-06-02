import 'package:places/data/model/place.dart';

class PlaceSearchState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final bool isShowQueriesHistory;
  final List<String> queries;
  final List<Place> places;

  PlaceSearchState({
    required this.isError,
    required this.errorMessage,
    required this.isLoading,
    required this.isShowQueriesHistory,
    required this.queries,
    required this.places,
  });

  factory PlaceSearchState.initial() => PlaceSearchState(
        isError: false,
        errorMessage: '',
        isLoading: false,
        isShowQueriesHistory: true,
        queries: const [],
        places: const [],
      );

  PlaceSearchState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isLoading,
    bool? isShowQueriesHistory,
    List<String>? queries,
    List<Place>? places,
  }) {
    return PlaceSearchState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isShowQueriesHistory: isShowQueriesHistory ?? this.isShowQueriesHistory,
      queries: queries ?? this.queries,
      places: places ?? this.places,
    );
  }
}
