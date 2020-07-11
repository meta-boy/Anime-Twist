// To parse this JSON data, do
//
//     final episode = episodeFromJson(jsonString);

// Dart imports:
import 'dart:convert';

List<Episode> episodeFromJson(String str) => List<Episode>.from(json.decode(str).map((x) => Episode.fromJson(x)));

String episodeToJson(List<Episode> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Episode {
    Episode({
        this.id,
        this.source,
        this.number,
        this.animeId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String source;
    int number;
    int animeId;
    DateTime createdAt;
    DateTime updatedAt;

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        source: json["source"],
        number: json["number"],
        animeId: json["anime_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "source": source,
        "number": number,
        "anime_id": animeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
