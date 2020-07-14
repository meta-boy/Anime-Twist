import 'dart:convert';

// Package imports:
import 'package:anime_twist/src/models/index.dart';
import 'package:momentum/momentum.dart';

// Project imports:
import 'index.dart';

class FavouriteModel extends MomentumModel<FavouriteController> {
  FavouriteModel(FavouriteController controller, {this.favourites})
      : super(controller);

  final Map<String, FavouriteElement> favourites;

  @override
  void update({Map<String, FavouriteElement> favourites}) {
    FavouriteModel(controller, favourites: favourites ?? this.favourites)
        .updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'favourites': Map<String, dynamic>.from(
          favourites.map((key, value) => MapEntry(key, value.toJson()))),
    };
  }

  FavouriteModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return FavouriteModel(controller,
        favourites: Map<String, FavouriteElement>.from(
          (map['favourites'])?.map(
              (key, value) => MapEntry(key, FavouriteElement.fromJson(value))),
        ));
  }
}
