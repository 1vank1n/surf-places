// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterCategory _$FilterCategoryFromJson(Map<String, dynamic> json) {
  return FilterCategory(
    title: json['title'] as String,
    placeType: json['placeType'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$FilterCategoryToJson(FilterCategory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'placeType': instance.placeType,
      'icon': instance.icon,
    };
