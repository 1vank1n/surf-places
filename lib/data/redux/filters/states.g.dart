// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersState _$FiltersStateFromJson(Map<String, dynamic> json) {
  return FiltersState(
    isError: json['isError'] as bool,
    errorMessage: json['errorMessage'] as String,
    isLoading: json['isLoading'] as bool,
    startRange: (json['startRange'] as num).toDouble(),
    endRange: (json['endRange'] as num).toDouble(),
    filteredTypes: (json['filteredTypes'] as List<dynamic>)
        .map((e) => FilterCategory.fromJson(e as Map<String, dynamic>))
        .toSet(),
    count: json['count'] as int?,
  );
}

Map<String, dynamic> _$FiltersStateToJson(FiltersState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'isError': instance.isError,
      'errorMessage': instance.errorMessage,
      'startRange': instance.startRange,
      'endRange': instance.endRange,
      'filteredTypes': instance.filteredTypes.toList(),
      'count': instance.count,
    };
