import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class SettingsState {
  final bool isDark;

  SettingsState({
    required this.isDark,
  });

  factory SettingsState.initial() => SettingsState(
        isDark: false,
      );

  SettingsState copyWith({
    bool? isDark,
  }) {
    return SettingsState(
      isDark: isDark ?? this.isDark,
    );
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);
}
