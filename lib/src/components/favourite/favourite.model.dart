import 'package:momentum/momentum.dart';

import 'index.dart';

class FavouriteModel extends MomentumModel<FavouriteController> {
  FavouriteModel(FavouriteController controller) : super(controller);

  // TODO: add your final properties here...

  @override
  void update() {
    FavouriteModel(
      controller,
    ).updateMomentum();
  }
}
