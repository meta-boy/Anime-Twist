import 'package:anime_twist/src/components/search/index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/pages/details.dart';
import 'package:anime_twist/src/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

class AnimeListCardItem extends StatefulWidget {
  const AnimeListCardItem({
    Key key,
    @required this.theme,
    @required this.anime,
  }) : super(key: key);

  final AnimeTwistTheme theme;
  final Anime anime;

  @override
  _AnimeListCardItemState createState() => _AnimeListCardItemState();
}

class _AnimeListCardItemState extends State<AnimeListCardItem> {
  SearchController _searchController;
  @override
  void didChangeDependencies() {
    _searchController = Momentum.controller<SearchController>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: getContrast(widget.theme.bodyBackground).withOpacity(0.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0.0,
        child: InkWell(
          splashColor: widget.theme.accent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (_) {
              var anime =
                  _searchController.getAnimeById(widget.anime.hbId.toString());

              return Details(anime: anime);
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.anime.title.length > 30
                          ? widget.anime.title.substring(0, 30) + '...'
                          : widget.anime.title),
                      Text(
                        widget.anime.altTitle != null &&
                                widget.anime.altTitle.length > 30
                            ? widget.anime.altTitle.substring(0, 30) + '...'
                            : '',
                        style: TextStyle(
                            color: widget.theme.textPrimary.withOpacity(0.5)),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.anime.ongoing == 1
                            ? Text(
                                'Ongoing',
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(
                                'Completed',
                                style: TextStyle(color: Colors.pink),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
