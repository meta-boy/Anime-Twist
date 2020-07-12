// Package imports:
import 'package:momentum/momentum.dart';

// Project imports:
import 'index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/services/anime_twist.dart';

class MiscController extends MomentumController<MiscModel> {
  @override
  MiscModel init() {
    return MiscModel(this,
        animeList: [],
        topRated: MetaData(),
        topAiring: MetaData(),
        motd: Motd(),
        lastUpdated: DateTime(2000));
  }

  Future<void> bootstrapAsync() async {
    ApiRepository apiRepository = getService<ConcreteApiRepository>();



    if (DateTime.now().difference(model.lastUpdated).inHours >= 6) {
      var _animeList = await apiRepository.getAllAnime();

      var _topRated = await apiRepository.getKitsuData(
          url:
              'https://kitsu.io/api/edge/anime?page[limit]=20&page[offset]=0&sort=-average_rating');

      var _topAiring = await apiRepository.getKitsuData(
          url:
              'https://kitsu.io/api/edge/anime?filter[status]=current&page[limit]=20&page[offset]=0&sort=-user_count');
      var _motd = await apiRepository.getMotd();

      model.update(
          topAiring: _topAiring,
          animeList: _animeList,
          topRated: _topRated,
          motd: _motd,
          lastUpdated: DateTime.now());
      print('updated');
    } else {
      print('did not update');
    }
  }
}
