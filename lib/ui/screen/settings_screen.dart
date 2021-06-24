import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/redux/settings/actions.dart';
import 'package:places/data/redux/settings/states.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:redux/redux.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: Theme.of(context).textTheme.headline3,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoreConnector<AppState, SettingsState>(
              converter: (Store<AppState> store) => store.state.settingsState,
              builder: (BuildContext context, SettingsState state) {
                Store<AppState> store = StoreProvider.of<AppState>(context);

                return SwitchListTile(
                  value: state.isDark,
                  onChanged: (_) {
                    store.dispatch(SetDarkSettingsAction(isDark: !state.isDark));
                  },
                  title: Text('Тёмная тема'),
                );
              },
            ),
            ListTile(
              title: Text('Смотреть туториал'),
              trailing: Icon(
                Icons.info_outline,
                color: successColor,
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
              },
            ),
          ],
        ),
      ),
    );
  }
}
