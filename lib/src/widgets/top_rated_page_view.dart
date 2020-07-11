// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

// Project imports:
import '../models/metadata.dart' as m;
import 'package:anime_twist/src/components/search/index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/pages/details.dart';

class TopRatedPageView extends StatefulWidget {
  const TopRatedPageView({
    Key key,
    @required this.topRated,
    @required this.theme,
    this.fontSize,
    this.containerPadding,
  }) : super(key: key);

  final m.MetaData topRated;
  final AnimeTwistTheme theme;
  final double fontSize;
  final double containerPadding;

  @override
  _TopRatedPageViewState createState() => _TopRatedPageViewState();
}

class _TopRatedPageViewState extends MomentumState<TopRatedPageView> {
  SearchController _searchController;
  List<Datum> topRated = <Datum>[];

  @override
  void initMomentumState() {
    _searchController = Momentum.controller<SearchController>(context);
    for (var anime in widget.topRated.data) {
      if (_searchController.exists(anime.id)) {
        topRated.add(anime);
      }
    }
    super.initMomentumState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (
        context,
        screenHeight,
        screenWidth,
        sx,
        sy,
      ) {
        return Container(
          height: screenHeight * 0.4,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.4, initialPage: 3),
            scrollDirection: Axis.horizontal,
            itemCount: topRated.length,
            itemBuilder: (context, index) {
              var current = topRated[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  splashColor: widget.theme.accent.withOpacity(0.3),
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (_) {
                      var anime = _searchController.getAnimeById(current.id);

                      return Details(anime: anime, imgUrl: current.attributes.posterImage.small ??
                                current.attributes.posterImage.medium,);
                    }));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            width: screenWidth * 0.35,
                            height: screenWidth * 0.35 * 780/550,
                            imageUrl: current.attributes.posterImage.small ??
                                current.attributes.posterImage.medium,
                            placeholder: (context, url) {
                              return Container(
                                width: screenWidth * 0.5,
                                color: Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(widget.containerPadding),
                                    child:
                                        Image.asset('assets/images/logo.png'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          current.attributes.titles.en ??
                              current.attributes.titles.enJp,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
