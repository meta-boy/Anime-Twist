import 'package:momentum/momentum.dart';

import 'index.dart';

class FavouriteController extends MomentumController<FavouriteModel> {
  @override
  FavouriteModel init() {
    return FavouriteModel(
      this,
      // TODO: specify initial values here...
    );
  }
}
