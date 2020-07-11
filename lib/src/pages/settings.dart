// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

// Project imports:
import 'package:anime_twist/src/components/theme/index.dart';
import 'package:anime_twist/src/utils/color.dart';
import 'package:anime_twist/src/widgets/index.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with RelativeScale {
  ThemeController _themeController;
  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _themeController ??= Momentum.controller<ThemeController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var currentTheme = CustomTheme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Toggle theme!'),
            subtitle: Text('click to toggle the theme'),
            trailing: _themeController.model.activeTheme == 0
                ? Icon(Icons.brightness_4, color: getContrast(currentTheme.bodyBackground),)
                : Icon(Icons.brightness_high, color: getContrast(currentTheme.bodyBackground)),
            onTap: () {
              if (_themeController.model.activeTheme == 0) {
                _themeController.selectTheme(1);
              } else {
                _themeController.selectTheme(0);
              }
            },
          )
        ],
      ),
    );
  }
}
