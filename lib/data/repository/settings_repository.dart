import 'dart:convert';

import 'package:places/data/redux/filters/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  // static const PLACES_FILTER = 'PLACES_FILTER';

  // Future<bool> setPlacesFilter({required PlacesFilterRequestDto placesFilter}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(PLACES_FILTER, json.encode(placesFilter.toJson()));
  // }

  // Future<PlacesFilterRequestDto> getPlacesFilter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? rawString = prefs.getString(PLACES_FILTER);
  //   if (rawString == null) {
  //     return PlacesFilterRequestDto.initial();
  //   }

  //   final Map<String, dynamic> rawJson = json.decode(rawString);
  //   return PlacesFilterRequestDto.fromJson(rawJson);
  // }

  static const FILTER_STATE = 'FILTER_STATE';

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
}
