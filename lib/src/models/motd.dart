// To parse this JSON data, do
//
//     final motd = motdFromJson(jsonString);

import 'dart:convert';

Motd motdFromJson(String str) => Motd.fromJson(json.decode(str));

String motdToJson(Motd data) => json.encode(data.toJson());

class Motd {
    Motd({
        this.message,
        this.id,
        this.title,
    });

    String message;
    int id;
    String title;

    factory Motd.fromJson(Map<String, dynamic> json) => Motd(
        message: json["message"],
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "title": title,
    };
}
