// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:device_preview/device_preview.dart';
import 'package:momentum/momentum.dart';

// Project imports:
import '.env.dart';
import 'src/components/detail/detail.controller.dart';
import 'src/components/favourite/favourite.controller.dart';
import 'src/components/misc/misc.controller.dart';
import 'src/components/search/search.controller.dart';
import 'src/components/theme/index.dart';
import 'src/pages/index.dart';
import 'src/services/anime_twist.dart';
import 'src/services/client_db.dart';
import 'src/widgets/index.dart';

const env = environment;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => momentum(),
    ),
  );
}

Momentum momentum() {
  return Momentum(
    child: AnimeTwist(),
    appLoader: Splash(),
    controllers: [
      ThemeController(),
      SearchController(),
      FavouriteController(),
      DetailController(),
      MiscController()..config(lazy: false),
    ],
    services: [
      ClientDB(),
      Router([Home()]),
      ConcreteApiRepository()
    ],
    persistSave: (context, key, value) async {
      var sharedPref = await ClientDB.getByContext(context);
      var result = await sharedPref.setString(key, value);
      return result;
    },
    persistGet: (context, key) async {
      var sharedPref = await ClientDB.getByContext(context);
      var result = sharedPref.getString(key);
      return result;
    },
  );
}

class AnimeTwist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [ThemeController],
      builder: (context, snapshot) {
        var theme = snapshot<ThemeModel>().controller.selectedTheme();
        return CustomTheme(
          theme: theme,
          child: MaterialApp(
            title: 'AnimeTwist',
            locale: DevicePreview.of(context).locale, // <--- Add the locale
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
              primarySwatch: theme.primary,
              accentColor: theme.accent,
              backgroundColor: theme.bodyBackground,
              scaffoldBackgroundColor: theme.bodyBackground,
              textTheme: TextTheme(
                bodyText1: TextStyle(color: theme.textPrimary),
                button: TextStyle(color: theme.textPrimary),
                caption: TextStyle(color: theme.textPrimary),
                bodyText2: TextStyle(color: theme.textPrimary),
                subtitle1: TextStyle(color: theme.textPrimary),
                subtitle2: TextStyle(color: theme.textPrimary),
                overline: TextStyle(color: theme.textPrimary),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: Router.getActivePage(context),
          ),
        );
      },
    );
  }
}
