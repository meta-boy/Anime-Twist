// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

// Project imports:
import 'package:anime_twist/src/components/misc/index.dart';
import 'package:anime_twist/src/components/search/index.dart';
import 'package:anime_twist/src/pages/index.dart';
import 'package:anime_twist/src/pages/settings.dart';
import 'package:anime_twist/src/utils/index.dart';
import 'package:anime_twist/src/widgets/index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RelativeScale {
  MiscController _miscController;
  ScrollController scrollController = ScrollController();
  SearchController _searchController;
  bool isTop = true;
  bool isMotdClosed = false;
  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _miscController ??= Momentum.controller<MiscController>(context);
    _searchController ??= Momentum.controller<SearchController>(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          setState(() {
            isTop = true;
          });
        } else {
          setState(() {
            isTop = false;
          });
        }
      } else {
        if (isTop) {
          setState(() {
            isTop = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme.accent,
          size: sx(24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: MomentumBuilder(
            controllers: [SearchController],
            builder: (context, snapshot) {
              var searchModel = snapshot<SearchModel>();
              if (searchModel.isSearching) {
                return TextFormField(
                  initialValue: searchModel.query,
                  
                  onChanged: (value) {
                    _searchController.search(value);
                  },
                  style: TextStyle(
                    fontSize: sy(12),
                    color: theme.accent,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      fontSize: sx(22),
                      color: theme.accent,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.accent,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.accent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.accent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }
              return RichText(
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
              );
            }),
        actions: [
          MomentumBuilder(
            controllers: [SearchController],
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(_searchController.model.isSearching
                    ? Icons.close
                    : Icons.search),
                onPressed: () {
                  _searchController.toggleSearch();
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => Favourites()));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => Settings()));
            },
          ),
        ],
      ),
      floatingActionButton: !isTop
          ? FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
      body: MomentumBuilder(
        controllers: [MiscController, SearchController],
        builder: (context, snapshot) {
          var animeList = _miscController.model.animeList;
          var topRated = _miscController.model.topRated;
          var topAired = _miscController.model.topAiring;
          var motd = _miscController.model.motd;
          return !_searchController.model.isSearching
              ? CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: !isMotdClosed
                          ? Dismissible(
                              onDismissed: (direction) {
                                setState(() {
                                  isMotdClosed = true;
                                });
                              },
                              key: ValueKey(motd),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: theme.accent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SelectableText.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: motd.title + '\n',
                                              style: TextStyle(
                                                  fontSize: sy(12),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            TextSpan(
                                              text: removeAllHtmlTags(
                                                motd.message,
                                              ),
                                              style: TextStyle(
                                                  fontSize: sy(10),
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          HeadingText(
                              theme: theme, fv: sx(28), text: 'Top Rated'),
                          TopRatedPageView(
                            topRated: topRated,
                            theme: theme,
                            fontSize: sx(20),
                            containerPadding: sx(80),
                          ),
                          SizedBox(height: sy(20)),
                          HeadingText(
                              theme: theme, fv: sx(28), text: 'Top Aired'),
                          TopRatedPageView(
                            topRated: topAired,
                            theme: theme,
                            fontSize: sx(20),
                            containerPadding: sx(80),
                          ),
                          SizedBox(height: sy(20)),
                          HeadingText(
                              theme: theme, fv: sx(28), text: 'All Anime'),
                        ],
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      var anime = animeList[index];

                      return AnimeListCardItem(theme: theme, anime: anime);
                    }, childCount: animeList.length))
                  ],
                )
              : _searchController.model.results.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchController.model.results.length,
                      itemBuilder: (context, index) {
                        var anime = _searchController.model.results[index];

                        return AnimeListCardItem(theme: theme, anime: anime);
                      })
                  : Center(
                      child: Container(
                          child: Text('(＞ｍ＜)\n\nOOPS! coudn\'t find that anime',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: theme.accent,
                                fontSize: sy(14),
                              ))),
                    );
        },
      ),
    );
  }
}
