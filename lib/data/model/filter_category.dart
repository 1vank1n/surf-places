import 'package:equatable/equatable.dart';
import 'package:places/ui/res/icons.dart';

class FilterCategory extends Equatable {
  final String title;
  final String icon;

  FilterCategory({
    required this.title,
    required this.icon,
  });

  static Set<FilterCategory> initialSet() => {
        FilterCategory(
          title: 'Здание',
          icon: iconMuseum,
        ),
        FilterCategory(
          title: 'Памятник',
          icon: iconPark,
        ),
        FilterCategory(
          title: 'Кафе',
          icon: iconCafe,
        ),
      };

  @override
  List<Object?> get props => [title, icon];
}
