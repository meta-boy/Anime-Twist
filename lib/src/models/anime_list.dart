import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'index.dart';

List<Anime> animeFromJson(String str) =>
    List<Anime>.from(json.decode(str).map((x) => Anime.fromJson(x)));

String animeToJson(List<Anime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Anime extends Equatable {
  Anime({
    this.id,
    this.title,
    this.altTitle,
    this.season,
    this.ongoing,
    this.hbId,
    this.createdAt,
    this.updatedAt,
    this.hidden,
    this.malId,
    this.slug,
  });

  int id;
  String title;
  String altTitle;
  int season;
  int ongoing;
  int hbId;
  DateTime createdAt;
  DateTime updatedAt;
  int hidden;
  int malId;
  Slug slug;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        id: json["id"],
        title: json["title"],
        altTitle: json["alt_title"] == null ? null : json["alt_title"],
        season: json["season"],
        ongoing: json["ongoing"],
        hbId: json["hb_id"] == null ? null : json["hb_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        hidden: json["hidden"],
        malId: json["mal_id"] == null ? null : json["mal_id"],
        slug: Slug.fromJson(json["slug"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "alt_title": altTitle == null ? null : altTitle,
        "season": season,
        "ongoing": ongoing,
        "hb_id": hbId == null ? null : hbId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "hidden": hidden,
        "mal_id": malId == null ? null : malId,
        "slug": slug.toJson(),
      };

  @override

  List<Object> get props => [
        id,
        title,
        altTitle,
        season,
        slug,
        ongoing,
        hbId,
        createdAt,
        updatedAt,
        hidden,
        malId,
        slug
      ];
}
