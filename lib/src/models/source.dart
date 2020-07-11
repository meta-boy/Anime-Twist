// To parse this JSON data, do
//
//     final source = sourceFromJson(jsonString);

import 'dart:convert';

List<Source> sourceFromJson(String str) => List<Source>.from(json.decode(str).map((x) => Source.fromJson(x)));

String sourceToJson(List<Source> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Source {
    Source({
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

    factory Source.fromJson(Map<String, dynamic> json) => Source(
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
