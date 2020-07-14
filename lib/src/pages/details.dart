// Flutter imports:
import 'package:anime_twist/src/components/favourite/favourite.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

// Project imports:
import 'package:anime_twist/src/components/search/index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/pages/player.dart';
import 'package:anime_twist/src/utils/color.dart';
import 'package:anime_twist/src/utils/crypto_helper.dart';
import 'package:anime_twist/src/widgets/custom_theme.dart';

class Details extends StatefulWidget {
  final Anime anime;
  final String imgUrl;

  const Details({
    Key key,
    this.anime,
    this.imgUrl,
  }) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends MomentumState<Details> with RelativeScale {
  SearchController _searchController;
  FavouriteController _favouriteController;
  
  String imgUrl;
  AnimeDetail animeDetails;
  ScrollController scrollController = ScrollController();
  List<Source> sources;

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    super.didChangeDependencies();
  }

  @override
  void initMomentumState() {
    _searchController = Momentum.controller<SearchController>(context);
    _favouriteController = Momentum.controller<FavouriteController>(context);

    if (widget.imgUrl == null) {
      _searchController
          .getKitsuData(widget.anime.hbId.toString())
          .then((resource) {
        setState(() {
          imgUrl = resource.data.attributes.posterImage.small ??
              resource.data.attributes.posterImage.medium ??
              resource.data.attributes.coverImage.small ??
              resource.data.attributes.coverImage.large;
        });
      });
    } else {
      imgUrl = widget.imgUrl;
    }

    _searchController.getAnimeDetails(widget.anime).then((value) {
      setState(() {
        animeDetails = value;
      });
    });
    _searchController.getSources(widget.anime).then((value) {
      setState(() {
        sources = value;
      });
    });
    super.initMomentumState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'twist.',
                style: TextStyle(
                  color: getContrast(theme.bodyBackground),
                  fontSize: sx(24),
                ),
              ),
              TextSpan(
                text: 'moe',
                style: TextStyle(
                  color: theme.accent,
                  fontSize: sx(24),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: getContrast(theme.bodyBackground)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
        child: Icon(Icons.arrow_downward),
      ),
      body: imgUrl == null || animeDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: Container(),
                  expandedHeight: screenHeight * 0.23,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    height: screenHeight * 0.2,
                                    width: screenHeight * 0.2 * 550 / 780,
                                    imageUrl: imgUrl,
                                    placeholder: (context, url) {
                                      return Container(
                                        height: screenHeight * 0.2,
                                        width: screenHeight * 0.2 * 550 / 780,
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(sx(32)),
                                            child: Image.asset(
                                                'assets/images/logo.png'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          animeDetails.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: theme.accent,
                                              fontSize: sx(22),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          animeDetails.episodes.length
                                                  .toString() +
                                              ' episode' +
                                              (animeDetails.episodes.length > 1
                                                  ? 's\n'
                                                  : '\n'),
                                          style: TextStyle(
                                              fontSize: sx(16),
                                              color: getContrast(
                                                      theme.bodyBackground)
                                                  .withOpacity(0.5)),
                                        ),
                                        Text(
                                          animeDetails.description ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: sx(16),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\nSeason ' +
                                                  animeDetails.season
                                                      .toString(),
                                              style: TextStyle(
                                                color: theme.accent,
                                                fontSize: sx(16),
                                              ),
                                            ),
                                            MomentumBuilder(
                                                controllers: [
                                                  FavouriteController
                                                ],
                                                builder: (context, snapshot) {
                                                  var anime = widget.anime;

                                                  var isFav =
                                                      _favouriteController
                                                          .isFav(anime.hbId
                                                              .toString());
                                                  print(isFav);
                                                  var favElement =
                                                      FavouriteElement(
                                                          anime.hbId.toString(),
                                                          imgUrl,
                                                          anime.title);
                                                  if (isFav) {
                                                    return IconButton(
                                                        icon: Icon(
                                                            Icons.favorite),
                                                        color: theme.accent,
                                                        onPressed: () {
                                                          _favouriteController
                                                              .update(
                                                                  favElement);
                                                        });
                                                  } else {
                                                    return IconButton(
                                                        icon: Icon(Icons
                                                            .favorite_border),
                                                        color: theme.accent,
                                                        onPressed: () {
                                                          _favouriteController
                                                              .update(
                                                                  favElement);
                                                        });
                                                  }
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          splashColor: theme.accent.withOpacity(0.3),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) {
                                  var url =
                                      decryptSourceUrl(sources[index].source);
                                  return PlayerPage(
                                    videoUrl: url,
                                    slug: animeDetails.slug.slug,
                                    ep: index + 1,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: getContrast(theme.bodyBackground)
                                    .withOpacity(0.07),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Episode ${index + 1}',
                                    style: TextStyle(
                                      color: getContrast(theme.bodyBackground),
                                      fontSize: sx(16),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    );
                  }, childCount: animeDetails.episodes.length),
                )
              ],
            ),
    );
  }
}
