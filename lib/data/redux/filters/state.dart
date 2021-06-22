import 'package:places/data/model/filter_category.dart';

class FiltersState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final double startRange;
  final double endRange;
  final Set<FilterCategory> filteredTypes;
  final int? count;

  FiltersState({
    required this.isError,
    required this.errorMessage,
    required this.isLoading,
    required this.startRange,
    required this.endRange,
    required this.filteredTypes,
    this.count,
  });

  factory FiltersState.initial() => FiltersState(
        isError: false,
        errorMessage: '',
        isLoading: false,
        startRange: 100.0,
        endRange: 5500.0,
        filteredTypes: FilterCategory.initialSet(),
      );

  FiltersState copyWith({
    bool? isError,
    String? errorMessage,
    bool? isLoading,
    double? startRange,
    double? endRange,
    Set<FilterCategory>? filteredTypes,
    int? count,
  }) {
    return FiltersState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      startRange: startRange ?? this.startRange,
      endRange: endRange ?? this.endRange,
      filteredTypes: filteredTypes ?? this.filteredTypes,
      count: count ?? this.count,
    );
  }
}
