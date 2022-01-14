// To parse this JSON data, do
//
//  final breedsModel = breedsModelFromMap(jsonString);
//  String breedsModelToJson(List<BreedsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BreedsModel {
    BreedsModel({
        this.weight,
        this.height,
        this.id,
        this.name,
        this.bredFor,
        this.breedGroup,
        this.lifeSpan,
        this.temperament,
        this.origin,
        this.referenceImageId,
        this.image,
        this.countryCode,
        this.description,
        this.history,
    });

    final Eight weight;
    final Eight height;
    final int id;
    final String name;
    final String bredFor;
    final BreedGroup breedGroup;
    final String lifeSpan;
    final String temperament;
    final String origin;
    final String referenceImageId;
    final Image image;
    final CountryCode countryCode;
    final String description;
    final String history;

    factory BreedsModel.fromMap(Map<String, dynamic> json) => BreedsModel(
        weight: Eight.fromMap(json["weight"]),
        height: Eight.fromMap(json["height"]),
        id: json["id"],
        name: json["name"],
        bredFor: json["bred_for"] == null ? null : json["bred_for"],
        breedGroup: json["breed_group"] == null ? null : breedGroupValues.map[json["breed_group"]],
        lifeSpan: json["life_span"],
        temperament: json["temperament"] == null ? null : json["temperament"],
        origin: json["origin"] == null ? null : json["origin"],
        referenceImageId: json["reference_image_id"],
        image: Image.fromMap(json["image"]),
        countryCode: json["country_code"] == null ? null : countryCodeValues.map[json["country_code"]],
        description: json["description"] == null ? null : json["description"],
        history: json["history"] == null ? null : json["history"],
    );

    Map<String, dynamic> toMap() => {
        "weight": weight.toMap(),
        "height": height.toMap(),
        "id": id,
        "name": name,
        "bred_for": bredFor == null ? null : bredFor,
        "breed_group": breedGroup == null ? null : breedGroupValues.reverse[breedGroup],
        "life_span": lifeSpan,
        "temperament": temperament == null ? null : temperament,
        "origin": origin == null ? null : origin,
        "reference_image_id": referenceImageId,
        "image": image.toMap(),
        "country_code": countryCode == null ? null : countryCodeValues.reverse[countryCode],
        "description": description == null ? null : description,
        "history": history == null ? null : history,
    };
}

enum BreedGroup { TOY, HOUND, TERRIER, WORKING, MIXED, EMPTY, NON_SPORTING, SPORTING, HERDING }

final breedGroupValues = EnumValues({
    "": BreedGroup.EMPTY,
    "Herding": BreedGroup.HERDING,
    "Hound": BreedGroup.HOUND,
    "Mixed": BreedGroup.MIXED,
    "Non-Sporting": BreedGroup.NON_SPORTING,
    "Sporting": BreedGroup.SPORTING,
    "Terrier": BreedGroup.TERRIER,
    "Toy": BreedGroup.TOY,
    "Working": BreedGroup.WORKING
});

enum CountryCode { AG, US, AU }

final countryCodeValues = EnumValues({
    "AG": CountryCode.AG,
    "AU": CountryCode.AU,
    "US": CountryCode.US
});

class Eight {
    Eight({
        this.imperial,
        this.metric,
    });

    final String imperial;
    final String metric;

    factory Eight.fromMap(Map<String, dynamic> json) => Eight(
        imperial: json["imperial"],
        metric: json["metric"],
    );

    Map<String, dynamic> toMap() => {
        "imperial": imperial,
        "metric": metric,
    };
}

class Image {
    Image({
        this.id,
        this.width,
        this.height,
        this.url,
    });

    final String id;
    final int width;
    final int height;
    final String url;

    factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
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
