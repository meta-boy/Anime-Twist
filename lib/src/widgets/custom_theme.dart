// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../models/index.dart';

class CustomTheme extends InheritedWidget {
  CustomTheme({
    Key key,
    Widget child,
    @required this.theme,
  }) : super(key: key, child: child);

  final AnimeTwistTheme theme;

  static AnimeTwistTheme of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(CustomTheme) as CustomTheme).theme;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) {
    var notSameTheme = oldWidget.theme != theme;
    return notSameTheme;
  }
}
