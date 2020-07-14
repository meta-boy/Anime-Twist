// Package imports:
import 'package:momentum/momentum.dart';

// Project imports:
import 'index.dart';
import 'package:anime_twist/src/models/index.dart';

class FavouriteController extends MomentumController<FavouriteModel> {
  @override
  FavouriteModel init() {
    return FavouriteModel(this, favourites: <String, FavouriteElement>{});
  }

  void update(FavouriteElement element) {
    var newMap = Map<String, FavouriteElement>.from(model.favourites);
    if (!newMap.containsKey(element.id)) {
      newMap.addEntries([MapEntry(element.id, element)]);
    } else {
      newMap.remove(element.id);
    }
    model.update(favourites: newMap);
  }

  void clear() {
    model.update(favourites: <String, FavouriteElement>{});
  }

  bool isFav(String id) {
    if (model.favourites.containsKey(id)) {
      return true;
    }
    return false;
  }
}
