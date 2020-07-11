// Package imports:
import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

// Project imports:
import '../../models/index.dart';
import 'index.dart';

class ThemeModel extends MomentumModel<ThemeController> with EquatableMixin {
  ThemeModel(
    ThemeController controller, {
    this.activeTheme,
  }) : super(controller);

  final int activeTheme;

  @override
  void update({
    List<AnimeTwistTheme> themes,
    int activeTheme,
  }) {
    ThemeModel(
      controller,
      activeTheme: activeTheme ?? this.activeTheme,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'activeTheme': activeTheme,
    };
  }

  ThemeModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ThemeModel(
      controller,
      activeTheme: json['activeTheme'],
    );
  }

  @override
  List<Object> get props => [
        activeTheme,
      ];
}
