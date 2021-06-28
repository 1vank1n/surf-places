import 'package:places/data/redux/settings/actions.dart';
import 'package:places/data/redux/settings/states.dart';
import 'package:places/data/repository/settings_repository.dart';
import 'package:redux/redux.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, SetDarkSettingsAction>(_setDark),
]);

SettingsState _setDark(
  SettingsState state,
  SetDarkSettingsAction action,
) {
  final newState = state.copyWith(isDark: action.isDark);
  SettingsRepository().setSettingsState(newState);
  return newState;
}
