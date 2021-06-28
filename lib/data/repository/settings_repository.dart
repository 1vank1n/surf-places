import 'dart:convert';

import 'package:places/data/redux/filters/states.dart';
import 'package:places/data/redux/settings/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const FILTER_STATE = 'FILTER_STATE';
  static const SETTINGS_STATE = 'SETTINGS_STATE';
  static const IS_ONBOARDING_SHOWN = 'IS_ONBOARDING_SHOWN';

  Future<bool> setFiltersState(FiltersState state) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(FILTER_STATE, json.encode(state.toJson()));
  }

  Future<FiltersState> getFiltersState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawString = prefs.getString(FILTER_STATE);
    if (rawString == null) {
      return FiltersState.initial();
    }

    final Map<String, dynamic> rawJson = json.decode(rawString);
    return FiltersState.fromJson(rawJson);
  }

  Future<bool> setSettingsState(SettingsState state) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(SETTINGS_STATE, json.encode(state.toJson()));
  }

  Future<SettingsState> getSettingsState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawString = prefs.getString(SETTINGS_STATE);
    if (rawString == null) {
      return SettingsState();
    }

    final Map<String, dynamic> rawJson = json.decode(rawString);
    return SettingsState.fromJson(rawJson);
  }

  Future<bool> setIsOnboardingShow(bool isOnboardingShow) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(IS_ONBOARDING_SHOWN, isOnboardingShow);
  }

  Future<bool> getIsOnboardingShow() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_ONBOARDING_SHOWN) ?? false;
  }
}
