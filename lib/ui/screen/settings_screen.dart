import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsInteractor _settingsInteractor;

  @override
  void initState() {
    super.initState();
    _settingsInteractor = context.read<SettingsInteractor>();
  }

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
            Consumer<AppModel>(
              builder: (context, appModel, child) {
                return SwitchListTile(
                  value: appModel.theme == darkThemeData,
                  onChanged: (_) {
                    _settingsInteractor.toggleTheme(appModel);
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
