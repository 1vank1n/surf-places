abstract class SettingsAction {}

class SetDarkSettingsAction extends SettingsAction {
  final bool isDark;

  SetDarkSettingsAction({required this.isDark});
}
