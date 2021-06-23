import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:places/ui/res/icons.dart';

part 'filter_category.g.dart';

@JsonSerializable()
class FilterCategory extends Equatable {
  final String title;
  final String placeType;
  final String icon;

  FilterCategory({
    required this.title,
    required this.placeType,
    required this.icon,
  });

  static Set<FilterCategory> initialSet() => {
        FilterCategory(
          title: 'Отель',
          placeType: 'hotel',
          icon: iconHotel,
        ),
        FilterCategory(
          title: 'Ресторан',
          placeType: 'restaurant',
          icon: iconRestaurant,
        ),
        FilterCategory(
          title: 'Особое место',
          placeType: 'other',
          icon: iconOther,
        ),
        FilterCategory(
          title: 'Парк',
          placeType: 'park',
          icon: iconPark,
        ),
        FilterCategory(
          title: 'Музей',
          placeType: 'museum',
          icon: iconMuseum,
        ),
        FilterCategory(
          title: 'Кафе',
          placeType: 'cafe',
          icon: iconCafe,
        ),
      };

  @override
  List<Object?> get props => [placeType];

  factory FilterCategory.fromJson(Map<String, dynamic> json) => _$FilterCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FilterCategoryToJson(this);
}
