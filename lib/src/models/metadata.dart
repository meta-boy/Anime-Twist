// To parse this JSON data, do
//
//     final metaData = metaDataFromJson(jsonString);

import 'dart:convert';

MetaData metaDataFromJson(String str) => MetaData.fromJson(json.decode(str));

String metaDataToJson(MetaData data) => json.encode(data.toJson());

class MetaData {
    MetaData({
        this.data,
        this.meta,
        this.links,
    });

    List<Datum> data;
    MetaDataMeta meta;
    MetaDataLinks links;

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : MetaDataMeta.fromJson(json["meta"]),
        links: json["links"] == null ? null : MetaDataLinks.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta == null ? null : meta.toJson(),
        "links": links == null ? null : links.toJson(),
    };
}

class Datum {
    Datum({
        this.id,
        this.type,
        this.links,
        this.attributes,
        this.relationships,
    });

    String id;
    TypeEnum type;
    DatumLinks links;
    Attributes attributes;
    Map<String, Relationship> relationships;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : typeEnumValues.map[json["type"]],
        links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
        attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null ? null : Map.from(json["relationships"]).map((k, v) => MapEntry<String, Relationship>(k, Relationship.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : typeEnumValues.reverse[type],
        "links": links == null ? null : links.toJson(),
        "attributes": attributes == null ? null : attributes.toJson(),
        "relationships": relationships == null ? null : Map.from(relationships).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Attributes {
    Attributes({
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.synopsis,
        this.coverImageTopOffset,
        this.titles,
        this.canonicalTitle,
        this.abbreviatedTitles,
        this.averageRating,
        this.ratingFrequencies,
        this.userCount,
        this.favoritesCount,
        this.startDate,
        this.endDate,
        this.nextRelease,
        this.popularityRank,
        this.ratingRank,
        this.ageRating,
        this.ageRatingGuide,
        this.subtype,
        this.status,
        this.tba,
        this.posterImage,
        this.coverImage,
        this.episodeCount,
        this.episodeLength,
        this.totalLength,
        this.youtubeVideoId,
        this.showType,
        this.nsfw,
    });

    DateTime createdAt;
    DateTime updatedAt;
    String slug;
    String synopsis;
    int coverImageTopOffset;
    Titles titles;
    String canonicalTitle;
    List<String> abbreviatedTitles;
    String averageRating;
    Map<String, String> ratingFrequencies;
    int userCount;
    int favoritesCount;
    DateTime startDate;
    DateTime endDate;
    dynamic nextRelease;
    int popularityRank;
    int ratingRank;
    AgeRating ageRating;
    AgeRatingGuide ageRatingGuide;
    ShowTypeEnum subtype;
    Status status;
    String tba;
    PosterImage posterImage;
    CoverImage coverImage;
    int episodeCount;
    int episodeLength;
    int totalLength;
    String youtubeVideoId;
    ShowTypeEnum showType;
    bool nsfw;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        slug: json["slug"] == null ? null : json["slug"],
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
        coverImageTopOffset: json["coverImageTopOffset"] == null ? null : json["coverImageTopOffset"],
        titles: json["titles"] == null ? null : Titles.fromJson(json["titles"]),
        canonicalTitle: json["canonicalTitle"] == null ? null : json["canonicalTitle"],
        abbreviatedTitles: json["abbreviatedTitles"] == null ? null : List<String>.from(json["abbreviatedTitles"].map((x) => x)),
        averageRating: json["averageRating"] == null ? null : json["averageRating"],
        ratingFrequencies: json["ratingFrequencies"] == null ? null : Map.from(json["ratingFrequencies"]).map((k, v) => MapEntry<String, String>(k, v)),
        userCount: json["userCount"] == null ? null : json["userCount"],
        favoritesCount: json["favoritesCount"] == null ? null : json["favoritesCount"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        nextRelease: json["nextRelease"],
        popularityRank: json["popularityRank"] == null ? null : json["popularityRank"],
        ratingRank: json["ratingRank"] == null ? null : json["ratingRank"],
        ageRating: json["ageRating"] == null ? null : ageRatingValues.map[json["ageRating"]],
        ageRatingGuide: json["ageRatingGuide"] == null ? null : ageRatingGuideValues.map[json["ageRatingGuide"]],
        subtype: json["subtype"] == null ? null : showTypeEnumValues.map[json["subtype"]],
        status: json["status"] == null ? null : statusValues.map[json["status"]],
        tba: json["tba"] == null ? null : json["tba"],
        posterImage: json["posterImage"] == null ? null : PosterImage.fromJson(json["posterImage"]),
        coverImage: json["coverImage"] == null ? null : CoverImage.fromJson(json["coverImage"]),
        episodeCount: json["episodeCount"] == null ? null : json["episodeCount"],
        episodeLength: json["episodeLength"] == null ? null : json["episodeLength"],
        totalLength: json["totalLength"] == null ? null : json["totalLength"],
        youtubeVideoId: json["youtubeVideoId"] == null ? null : json["youtubeVideoId"],
        showType: json["showType"] == null ? null : showTypeEnumValues.map[json["showType"]],
        nsfw: json["nsfw"] == null ? null : json["nsfw"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "slug": slug == null ? null : slug,
        "synopsis": synopsis == null ? null : synopsis,
        "coverImageTopOffset": coverImageTopOffset == null ? null : coverImageTopOffset,
        "titles": titles == null ? null : titles.toJson(),
        "canonicalTitle": canonicalTitle == null ? null : canonicalTitle,
        "abbreviatedTitles": abbreviatedTitles == null ? null : List<dynamic>.from(abbreviatedTitles.map((x) => x)),
        "averageRating": averageRating == null ? null : averageRating,
        "ratingFrequencies": ratingFrequencies == null ? null : Map.from(ratingFrequencies).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "userCount": userCount == null ? null : userCount,
        "favoritesCount": favoritesCount == null ? null : favoritesCount,
        "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "nextRelease": nextRelease,
        "popularityRank": popularityRank == null ? null : popularityRank,
        "ratingRank": ratingRank == null ? null : ratingRank,
        "ageRating": ageRating == null ? null : ageRatingValues.reverse[ageRating],
        "ageRatingGuide": ageRatingGuide == null ? null : ageRatingGuideValues.reverse[ageRatingGuide],
        "subtype": subtype == null ? null : showTypeEnumValues.reverse[subtype],
        "status": status == null ? null : statusValues.reverse[status],
        "tba": tba == null ? null : tba,
        "posterImage": posterImage == null ? null : posterImage.toJson(),
        "coverImage": coverImage == null ? null : coverImage.toJson(),
        "episodeCount": episodeCount == null ? null : episodeCount,
        "episodeLength": episodeLength == null ? null : episodeLength,
        "totalLength": totalLength == null ? null : totalLength,
        "youtubeVideoId": youtubeVideoId == null ? null : youtubeVideoId,
        "showType": showType == null ? null : showTypeEnumValues.reverse[showType],
        "nsfw": nsfw == null ? null : nsfw,
    };
}

enum AgeRating { PG, R, G }

final ageRatingValues = EnumValues({
    "G": AgeRating.G,
    "PG": AgeRating.PG,
    "R": AgeRating.R
});

enum AgeRatingGuide { TEENS_13_OR_OLDER, THE_17_VIOLENCE_PROFANITY, ALL_AGES }

final ageRatingGuideValues = EnumValues({
    "All Ages": AgeRatingGuide.ALL_AGES,
    "Teens 13 or older": AgeRatingGuide.TEENS_13_OR_OLDER,
    "17+ (violence & profanity)": AgeRatingGuide.THE_17_VIOLENCE_PROFANITY
});

class CoverImage {
    CoverImage({
        this.tiny,
        this.small,
        this.large,
        this.original,
        this.meta,
    });

    String tiny;
    String small;
    String large;
    String original;
    CoverImageMeta meta;

    factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        tiny: json["tiny"] == null ? null : json["tiny"],
        small: json["small"] == null ? null : json["small"],
        large: json["large"] == null ? null : json["large"],
        original: json["original"] == null ? null : json["original"],
        meta: json["meta"] == null ? null : CoverImageMeta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "tiny": tiny == null ? null : tiny,
        "small": small == null ? null : small,
        "large": large == null ? null : large,
        "original": original == null ? null : original,
        "meta": meta == null ? null : meta.toJson(),
    };
}

class CoverImageMeta {
    CoverImageMeta({
        this.dimensions,
    });

    PurpleDimensions dimensions;

    factory CoverImageMeta.fromJson(Map<String, dynamic> json) => CoverImageMeta(
        dimensions: json["dimensions"] == null ? null : PurpleDimensions.fromJson(json["dimensions"]),
    );

    Map<String, dynamic> toJson() => {
        "dimensions": dimensions == null ? null : dimensions.toJson(),
    };
}

class PurpleDimensions {
    PurpleDimensions({
        this.tiny,
        this.small,
        this.large,
    });

    Large tiny;
    Large small;
    Large large;

    factory PurpleDimensions.fromJson(Map<String, dynamic> json) => PurpleDimensions(
        tiny: json["tiny"] == null ? null : Large.fromJson(json["tiny"]),
        small: json["small"] == null ? null : Large.fromJson(json["small"]),
        large: json["large"] == null ? null : Large.fromJson(json["large"]),
    );

    Map<String, dynamic> toJson() => {
        "tiny": tiny == null ? null : tiny.toJson(),
        "small": small == null ? null : small.toJson(),
        "large": large == null ? null : large.toJson(),
    };
}

class Large {
    Large({
        this.width,
        this.height,
    });

    int width;
    int height;

    factory Large.fromJson(Map<String, dynamic> json) => Large(
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
    );

    Map<String, dynamic> toJson() => {
        "width": width == null ? null : width,
        "height": height == null ? null : height,
    };
}

class PosterImage {
    PosterImage({
        this.tiny,
        this.small,
        this.medium,
        this.large,
        this.original,
        this.meta,
    });

    String tiny;
    String small;
    String medium;
    String large;
    String original;
    PosterImageMeta meta;

    factory PosterImage.fromJson(Map<String, dynamic> json) => PosterImage(
        tiny: json["tiny"] == null ? null : json["tiny"],
        small: json["small"] == null ? null : json["small"],
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
        original: json["original"] == null ? null : json["original"],
        meta: json["meta"] == null ? null : PosterImageMeta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "tiny": tiny == null ? null : tiny,
        "small": small == null ? null : small,
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
        "original": original == null ? null : original,
        "meta": meta == null ? null : meta.toJson(),
    };
}

class PosterImageMeta {
    PosterImageMeta({
        this.dimensions,
    });

    FluffyDimensions dimensions;

    factory PosterImageMeta.fromJson(Map<String, dynamic> json) => PosterImageMeta(
        dimensions: json["dimensions"] == null ? null : FluffyDimensions.fromJson(json["dimensions"]),
    );

    Map<String, dynamic> toJson() => {
        "dimensions": dimensions == null ? null : dimensions.toJson(),
    };
}

class FluffyDimensions {
    FluffyDimensions({
        this.tiny,
        this.small,
        this.medium,
        this.large,
    });

    Large tiny;
    Large small;
    Large medium;
    Large large;

    factory FluffyDimensions.fromJson(Map<String, dynamic> json) => FluffyDimensions(
        tiny: json["tiny"] == null ? null : Large.fromJson(json["tiny"]),
        small: json["small"] == null ? null : Large.fromJson(json["small"]),
        medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
        large: json["large"] == null ? null : Large.fromJson(json["large"]),
    );

    Map<String, dynamic> toJson() => {
        "tiny": tiny == null ? null : tiny.toJson(),
        "small": small == null ? null : small.toJson(),
        "medium": medium == null ? null : medium.toJson(),
        "large": large == null ? null : large.toJson(),
    };
}

enum ShowTypeEnum { TV, SPECIAL, MOVIE }

final showTypeEnumValues = EnumValues({
    "movie": ShowTypeEnum.MOVIE,
    "special": ShowTypeEnum.SPECIAL,
    "TV": ShowTypeEnum.TV
});

enum Status { FINISHED }

final statusValues = EnumValues({
    "finished": Status.FINISHED
});

class Titles {
    Titles({
        this.en,
        this.enJp,
        this.enUs,
        this.jaJp,
    });

    String en;
    String enJp;
    String enUs;
    String jaJp;

    factory Titles.fromJson(Map<String, dynamic> json) => Titles(
        en: json["en"] == null ? null : json["en"],
        enJp: json["en_jp"] == null ? null : json["en_jp"],
        enUs: json["en_us"] == null ? null : json["en_us"],
        jaJp: json["ja_jp"] == null ? null : json["ja_jp"],
    );

    Map<String, dynamic> toJson() => {
        "en": en == null ? null : en,
        "en_jp": enJp == null ? null : enJp,
        "en_us": enUs == null ? null : enUs,
        "ja_jp": jaJp == null ? null : jaJp,
    };
}

class DatumLinks {
    DatumLinks({
        this.self,
    });

    String self;

    factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
        self: json["self"] == null ? null : json["self"],
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
    };
}

class Relationship {
    Relationship({
        this.links,
    });

    RelationshipLinks links;

    factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        links: json["links"] == null ? null : RelationshipLinks.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "links": links == null ? null : links.toJson(),
    };
}

class RelationshipLinks {
    RelationshipLinks({
        this.self,
        this.related,
    });

    String self;
    String related;

    factory RelationshipLinks.fromJson(Map<String, dynamic> json) => RelationshipLinks(
        self: json["self"] == null ? null : json["self"],
        related: json["related"] == null ? null : json["related"],
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "related": related == null ? null : related,
    };
}

enum TypeEnum { ANIME }

final typeEnumValues = EnumValues({
    "anime": TypeEnum.ANIME
});

class MetaDataLinks {
    MetaDataLinks({
        this.first,
        this.next,
        this.last,
    });

    String first;
    String next;
    String last;

    factory MetaDataLinks.fromJson(Map<String, dynamic> json) => MetaDataLinks(
        first: json["first"] == null ? null : json["first"],
        next: json["next"] == null ? null : json["next"],
        last: json["last"] == null ? null : json["last"],
    );

    Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "next": next == null ? null : next,
        "last": last == null ? null : last,
    };
}

class MetaDataMeta {
    MetaDataMeta({
        this.count,
    });

    int count;

    factory MetaDataMeta.fromJson(Map<String, dynamic> json) => MetaDataMeta(
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
