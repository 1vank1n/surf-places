import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState([
    @Default(false) bool isDark,
  ]) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
}
