// To parse this JSON data, do
//
//     final animeDetail = animeDetailFromJson(jsonString);

import 'dart:convert';

AnimeDetail animeDetailFromJson(String str) => AnimeDetail.fromJson(json.decode(str));

String animeDetailToJson(AnimeDetail data) => json.encode(data.toJson());

class AnimeDetail {
    AnimeDetail({
        this.id,
        this.title,
        this.altTitle,
        this.season,
        this.ongoing,
        this.description,
        this.hbId,
        this.createdAt,
        this.updatedAt,
        this.hidden,
        this.malId,
        this.slug,
        this.episodes,
    });

    int id;
    String title;
    dynamic altTitle;
    int season;
    int ongoing;
    String description;
    int hbId;
    DateTime createdAt;
    DateTime updatedAt;
    int hidden;
    int malId;
    Slug slug;
    List<Slug> episodes;

    factory AnimeDetail.fromJson(Map<String, dynamic> json) => AnimeDetail(
        id: json["id"],
        title: json["title"],
        altTitle: json["alt_title"],
        season: json["season"],
        ongoing: json["ongoing"],
        description: json["description"],
        hbId: json["hb_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        hidden: json["hidden"],
        malId: json["mal_id"],
        slug: Slug.fromJson(json["slug"]),
        episodes: List<Slug>.from(json["episodes"].map((x) => Slug.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "alt_title": altTitle,
        "season": season,
        "ongoing": ongoing,
        "description": description,
        "hb_id": hbId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "hidden": hidden,
        "mal_id": malId,
        "slug": slug.toJson(),
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    };
}

class Slug {
    Slug({
        this.id,
        this.number,
        this.animeId,
        this.createdAt,
        this.updatedAt,
        this.slug,
    });

    int id;
    int number;
    int animeId;
    DateTime createdAt;
    DateTime updatedAt;
    String slug;

    factory Slug.fromJson(Map<String, dynamic> json) => Slug(
        id: json["id"],
        number: json["number"] == null ? null : json["number"],
        animeId: json["anime_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slug: json["slug"] == null ? null : json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number == null ? null : number,
        "anime_id": animeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "slug": slug == null ? null : slug,
    };
}
