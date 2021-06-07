import 'package:places/data/redux/settings/actions.dart';
import 'package:places/data/redux/settings/state.dart';
import 'package:redux/redux.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, SetDarkSettingsAction>(_setDark),
]);

SettingsState _setDark(
  SettingsState state,
  SetDarkSettingsAction action,
) =>
    state.copyWith(isDark: action.isDark);
