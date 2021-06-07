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
}
