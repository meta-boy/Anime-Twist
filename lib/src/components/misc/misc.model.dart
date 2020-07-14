// Package imports:
import 'package:momentum/momentum.dart';

// Project imports:
import 'index.dart';
import 'package:anime_twist/src/models/anime_list.dart';
import 'package:anime_twist/src/models/index.dart';

class MiscModel extends MomentumModel<MiscController> {
  MiscModel(MiscController controller,
      {this.animeList,
      this.topAiring,
      this.topRated,
      this.motd,
      this.lastUpdated})
      : super(controller);

  final List<Anime> animeList;
  final MetaData topAiring;
  final MetaData topRated;
  final Motd motd;
  final DateTime lastUpdated;

  @override
  void update({
    List<Anime> animeList,
    MetaData topAiring,
    MetaData topRated,
    Motd motd,
    DateTime lastUpdated,
  }) {
    MiscModel(
      controller,
      animeList: animeList ?? this.animeList,
      topAiring: topAiring ?? this.topAiring,
      topRated: topRated ?? this.topRated,
      motd: motd ?? this.motd,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'animeList': animeList?.map((x) => x?.toJson())?.toList(),
      'topAiring': topAiring?.toJson(),
      'topRated': topRated?.toJson(),
      'motd': motd?.toJson(),
      'lastUpdated': lastUpdated?.millisecondsSinceEpoch,
    };
  }

  MiscModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return MiscModel(
      controller,
      animeList:
          List<Anime>.from(map['animeList']?.map((x) => Anime.fromJson(x))),
      topAiring: MetaData.fromJson(map['topAiring']),
      topRated: MetaData.fromJson(map['topRated']),
      motd: Motd.fromJson(map['motd']),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
    );
  }
}
