// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:momentum/momentum.dart';

// Project imports:
import 'details.dart';
import 'package:anime_twist/src/components/favourite/index.dart';
import 'package:anime_twist/src/components/search/index.dart';
import 'package:anime_twist/src/models/index.dart';
import 'package:anime_twist/src/widgets/custom_theme.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends MomentumState<Favourites> {
  FavouriteController _favouriteController;
  SearchController _searchController;

  List<FavouriteElement> favs;

  @override
  void initMomentumState() {
    _favouriteController = Momentum.controller<FavouriteController>(context);
    _searchController = Momentum.controller<SearchController>(context);

    super.initMomentumState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    final key = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Favourites"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () async {
                if (favs.isEmpty) {
                  key.currentState.showSnackBar(new SnackBar(
                    content: new Text("You did not favourite any anime you baakaaa~! >w<"),
                  ));
                  return;
                }
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: theme.bodyBackground,
                          title: Text(
                              "Would you like to clear your favourites?",
                              style: TextStyle(color: theme.accent)),
                          content: Text(
                            "You will have to manually add them later.",
                            style: TextStyle(color: theme.textPrimary),
                          ),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            FlatButton(
                              child: Text("CANCEL"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("YEAAA!!!"),
                              onPressed: () {
                                _favouriteController.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              })
        ],
      ),
      body: MomentumBuilder(
          controllers: [FavouriteController, SearchController],
          builder: (context, snapshot) {
            favs = List<FavouriteElement>.from(
                _favouriteController.model.favourites.values);
            return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: favs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 9 / 16,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  var fav = favs[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) {
                        var anime = _searchController.getAnimeById(fav.id);

                        return Details(
                          anime: anime,
                          imgUrl: fav.posterURl,
                        );
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(imageUrl: fav.posterURl)),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              fav.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
