import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';
import 'package:places/main.dart' show AppRouter;

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
            Consumer<AppModel>(
              builder: (context, appModel, child) {
                return SwitchListTile(
                  value: appModel.theme == darkThemeData,
                  onChanged: (_) {
                    appModel.toggleTheme();
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
