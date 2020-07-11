// To parse this JSON data, do
//
//     final kitsuResource = kitsuResourceFromJson(jsonString);

import 'dart:convert';

import 'index.dart';

KitsuResource kitsuResourceFromJson(String str) => KitsuResource.fromJson(json.decode(str));

String kitsuResourceToJson(KitsuResource data) => json.encode(data.toJson());

class KitsuResource {
    KitsuResource({
        this.data,
    });

    Data data;

    factory KitsuResource.fromJson(Map<String, dynamic> json) => KitsuResource(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.type,
        this.links,
        this.attributes,
        this.relationships,
    });

    String id;
    String type;
    DataLinks links;
    Attributes attributes;
    Map<String, Relationship> relationships;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        links: json["links"] == null ? null : DataLinks.fromJson(json["links"]),
        attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null ? null : Map.from(json["relationships"]).map((k, v) => MapEntry<String, Relationship>(k, Relationship.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "links": links == null ? null : links.toJson(),
        "attributes": attributes == null ? null : attributes.toJson(),
        "relationships": relationships == null ? null : Map.from(relationships).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}


class DataLinks {
    DataLinks({
        this.self,
    });

    String self;

    factory DataLinks.fromJson(Map<String, dynamic> json) => DataLinks(
        self: json["self"] == null ? null : json["self"],
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
    };
}
