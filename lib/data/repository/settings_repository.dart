import 'dart:convert';

import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const PLACES_FILTER = 'PLACES_FILTER';

  Future<bool> setPlacesFilter({required PlacesFilterRequestDto placesFilter}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(PLACES_FILTER, json.encode(placesFilter.json));
  }

  Future<PlacesFilterRequestDto> getPlacesFilter() async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawString = prefs.getString(PLACES_FILTER);
    if (rawString == null) {
      return PlacesFilterRequestDto.initial();
    }

    final Map<String, dynamic> rawJson = json.decode(rawString);
    return PlacesFilterRequestDto.fromJson(rawJson);
  }
}
