// To parse this JSON data, do
//
//  final breedsModel = breedsModelFromMap(jsonString);
//  String breedsModelToJson(List<BreedsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BreedsModel {
  BreedsModel({
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.referenceImageId,
    required this.image,
    required this.countryCode,
    required this.description,
    required this.history,
  });

  final Eight weight;
  final Eight height;
  final int id;
  final String name;
  final String bredFor;
  final BreedGroup? breedGroup;
  final String lifeSpan;
  final String temperament;
  final String origin;
  final String referenceImageId;
  final Image image;
  final CountryCode? countryCode;
  final String description;
  final String history;

  factory BreedsModel.fromMap(Map<String, dynamic> json) => BreedsModel(
        weight: Eight.fromMap(json["weight"]),
        height: Eight.fromMap(json["height"]),
        id: json["id"],
        name: json["name"],
        bredFor: json["bred_for"],
        breedGroup: json["breed_group"] == null
            ? null
            : breedGroupValues.map[json["breed_group"]],
        lifeSpan: json["life_span"],
        temperament: json["temperament"],
        origin: json["origin"],
        referenceImageId: json["reference_image_id"],
        image: Image.fromMap(json["image"]),
        countryCode: json["country_code"] == null
            ? null
            : countryCodeValues.map[json["country_code"]],
        description: json["description"],
        history: json["history"],
      );

  Map<String, dynamic> toMap() => {
        "weight": weight.toMap(),
        "height": height.toMap(),
        "id": id,
        "name": name,
        "bred_for": bredFor,
        "breed_group":
            breedGroup == null ? null : breedGroupValues.reverse[breedGroup],
        "life_span": lifeSpan,
        "temperament": temperament,
        "origin": origin,
        "reference_image_id": referenceImageId,
        "image": image.toMap(),
        "country_code": countryCodeValues.reverse[countryCode],
        "description": description,
        "history": history,
      };
}

enum BreedGroup {
  TOY,
  HOUND,
  TERRIER,
  WORKING,
  MIXED,
  EMPTY,
  NON_SPORTING,
  SPORTING,
  HERDING
}

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

final countryCodeValues = EnumValues(
    {"AG": CountryCode.AG, "AU": CountryCode.AU, "US": CountryCode.US});

class Eight {
  Eight({
    required this.imperial,
    required this.metric,
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
    required this.id,
    required this.width,
    required this.height,
    required this.url,
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
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
