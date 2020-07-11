// Package imports:
import 'package:momentum/momentum.dart';

// Project imports:
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
