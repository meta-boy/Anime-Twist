import 'dart:convert';

import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/models/metadata.dart';
import 'package:anime_twist/src/models/user.dart';
import 'package:momentum/momentum.dart';
import 'package:http/http.dart' as http;

abstract class ApiRepository {
  Future<List<Anime>> getAllAnime();

  Future<AnimeDetail> getAnimeInfo(Anime anime);
  getLibrary(User user);
  Future<List<Source>> getSources(Anime anime);
  Future<MetaData> getKitsuData({String url});
  Future<KitsuResource> getKitsuResource(String id);
  Future<Motd> getMotd();
}

class ConcreteApiRepository extends MomentumService with ApiRepository {
  static String _token = '1rj2vRtegS8Y60B3w3qNZm5T2Q0TN2NR';
  static String authority = 'twist.moe';
  static String base = 'api';

  static Map<String, String> headers = {
    'accept': 'application/json, text/plain, */*',
    'user-agent': 'AnimeTwist flutter',
    'x-access-token': _token
  };
  static Map<String, String> kitsuHeaders = {
    'accept': 'application/vnd.api+json',
    'content-type': 'application/vnd.api+json'
  };

  @override
  Future<List<Anime>> getAllAnime() async {
    final Uri uri = Uri.https(authority, '$base/anime');

    http.Response response = await http.get(uri, headers: headers);

    return animeFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Future<AnimeDetail> getAnimeInfo(Anime anime) async {
    final Uri uri = Uri.https(authority, '$base/anime/${anime.slug.slug}');
    http.Response response = await http.get(uri, headers: headers);

    return animeDetailFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  getLibrary(User user) async {
    throw UnimplementedError();
    // Yet to implement

    // final Uri uri = Uri.https(authority, '$base/library');
    // var _headers = headers;
    // headers.addEntries([MapEntry('jwt', user.token)]);
    // Options options = Options(headers: _headers);
    // Response response = await dio.get(uri.toString(), options: options);
  }

  @override
  Future<List<Source>> getSources(Anime anime) async {
    final Uri uri =
        Uri.https(authority, '$base/anime/${anime.slug.slug}/sources');
    http.Response response = await http.get(uri, headers: headers);

    return sourceFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Future<MetaData> getKitsuData(
      {String url =
          'https://kitsu.io/api/edge/anime?page[limit]=20&page[offset]=0'}) async {
    http.Response response = await http.get(url, headers: kitsuHeaders);

    return metaDataFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Future<KitsuResource> getKitsuResource(String id) async {
    String url = 'https://kitsu.io/api/edge/anime/$id';
    http.Response response = await http.get(url, headers: kitsuHeaders);

    return kitsuResourceFromJson(utf8.decode(response.bodyBytes));
  }

  @override
  Future<Motd> getMotd() async {
    final Uri uri = Uri.https(authority, '$base/motd');
    http.Response response = await http.get(uri, headers: headers);

    return motdFromJson(utf8.decode(response.bodyBytes));
  }
}
