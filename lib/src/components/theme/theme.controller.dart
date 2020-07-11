import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import 'index.dart';

class ThemeController extends MomentumController<ThemeModel> {
  @override
  ThemeModel init() {
    return ThemeModel(
      this,
      activeTheme: 0,
    );
  }

  void selectTheme(int index) {
    model.update(activeTheme: index);
  }

  AnimeTwistTheme selectedTheme() {
    return themes[model.activeTheme];
  }

  List<AnimeTwistTheme> get themes {
    return [
      indigoPinkLight,
      indigoPinkDark,
    ];
  }
}
