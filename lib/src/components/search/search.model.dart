import 'package:anime_twist/src/models/index.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SearchModel extends MomentumModel<SearchController> {
  SearchModel(SearchController controller, {this.isSearching, this.query, this.results}) : super(controller);

  final bool isSearching;
  final String query;
  final List<Anime> results;

  @override
  void update({bool isSearching, String query, List<Anime> results}) {
    SearchModel(
      controller,
        isSearching: isSearching ?? this.isSearching,
        query: query ?? this.query,
        results: results ?? this.results
    ).updateMomentum();
  }
}
