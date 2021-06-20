class BreedsModel {
  final String bredFor;
  final String breedGroup;
  final Height height;
  final String id;
  final DogImage image;
  final String lifeSpan;
  final String name;
  final String origin;
  final String referenceImageId;
  final String temperement;
  final Weight weight;

  BreedsModel(
      {this.bredFor,
      this.breedGroup,
      this.height,
      this.id,
      this.image,
      this.lifeSpan,
      this.name,
      this.origin,
      this.referenceImageId,
      this.temperement,
      this.weight});

  factory BreedsModel.fromJson(Map<String, dynamic> json) {
    return BreedsModel(
      bredFor: json['bred_for'],
      breedGroup: json['breed_group'],
      height: Height.fromJson(json['height']),
      id: json['id'].toString(),
      image: DogImage.fromJson(json['image']),
      lifeSpan: json['life_span'],
      name: json['name'],
      origin: json['origin'],
      referenceImageId: json['reference_image_id'],
      temperement: json['temperament'],
      weight: Weight.fromJson(json['weight']),
    );
  }
}

class Height {
  final String imperial;
  final String metric;

  Height({this.imperial, this.metric});

  factory Height.fromJson(Map<String, dynamic> json) {
    return Height(
      imperial: json['imperial'],
      metric: json['metric'],
    );
  }
}

class DogImage {
  final String height;
  final String id;
  final String url;
  final String width;

  DogImage({this.height, this.id, this.url, this.width});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(
      height: json['height'].toString(),
      id: json['id'],
      url: json['url'],
      width: json['width'].toString(),
    );
  }
}

class Weight {
  final String imperial;
  final String metric;

  Weight({this.imperial, this.metric});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      imperial: json['imperial'],
      metric: json['metric'],
    );
  }
}
