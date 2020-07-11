// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// Dart imports:
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.username,
        this.rank,
        this.donationRank,
        this.token,
    });

    int id;
    String username;
    int rank;
    int donationRank;
    String token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        rank: json["rank"],
        donationRank: json["donation_rank"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "rank": rank,
        "donation_rank": donationRank,
        "token": token,
    };
}
