import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/services/anime_twist.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class MiscController extends MomentumController<MiscModel> {
  @override
  MiscModel init() {
    return MiscModel(
      this,
      animeList: [],
      topRated: MetaData(),
      topAiring: MetaData(),
    );
  }

  Future<void> bootstrapAsync() async {
    ApiRepository apiRepository = getService<ConcreteApiRepository>();

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
    );
  }
}
