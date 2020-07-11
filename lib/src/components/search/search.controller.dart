import 'package:anime_twist/src/components/misc/index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/pages/details.dart';
import 'package:anime_twist/src/services/index.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SearchController extends MomentumController<SearchModel> {
  List<Anime> animeList;
  @override
  SearchModel init() {
    return SearchModel(this, isSearching: false, query: '', results: <Anime>[]);
  }

  @override
  Future<void> bootstrapAsync() {
    var miscController = dependOn<MiscController>();

    animeList = miscController.model.animeList;
    return super.bootstrapAsync();
  }

  void toggleSearch() {
    model.update(isSearching: !model.isSearching);
  }

  void search(String query) {
    var resultList = <Anime>[];
    for (var anime in animeList) {
      if (anime.title.toLowerCase().contains(model.query) ||
          (anime.altTitle != null &&
              anime.altTitle.toLowerCase().contains(model.query))) {
        resultList.add(anime);
      }
    }
    if (query == '' && resultList.isEmpty) {
      resultList = animeList;
    }
    model.update(results: resultList, query: query);
  }

  bool exists(String id) {
    bool isExist = false;
    for (var anime in animeList) {
      if (anime.hbId.toString() == id) {
        isExist = true;
      }
    }
    return isExist;
  }

  Anime getAnimeById(String id) {
    for (var anime in animeList) {
      if (anime.hbId.toString() == id) {
        return anime;
      }
    }
    return Anime();
  }

  Future<KitsuResource> getKitsuData(String id) async {
    ApiRepository apiRepository = getService<ConcreteApiRepository>();
    var kitsuData = await apiRepository.getKitsuResource(id);
    return kitsuData;
  }

  Future<AnimeDetail> getAnimeDetails(Anime anime) async {
    ApiRepository apiRepository = getService<ConcreteApiRepository>();
    var animeDetails = await apiRepository.getAnimeInfo(anime);
    return animeDetails;
  }

  Future<List<Source>> getSources(Anime anime) async {
    ApiRepository apiRepository = getService<ConcreteApiRepository>();
    return apiRepository.getSources(anime);
  }
}
