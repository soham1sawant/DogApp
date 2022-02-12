import 'package:dog_app/data/models/breeds/height.dart';
import 'package:dog_app/data/models/breeds/image.dart';
import 'package:dog_app/data/models/breeds/weight.dart';
import 'package:json_annotation/json_annotation.dart';

part 'breeds_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BreedsModel {

  @JsonKey(name: 'bred_for')
  final String? bredFor;
  @JsonKey(name: 'breed_group')
  String? breedGroup;
  final Height? height;
  final int id;
  final Image image;
  final String? lifeSpan;
  final String name;
  final String? origin;
  @JsonKey(name: 'reference_image_id')
  String? referenceImageId;
  final String? temperament;
  final Weight weight;
  @JsonKey(name: 'country_code')
  String? countryCode;

  BreedsModel(
    this.bredFor,
    this.height,
    this.id,
    this.image,
    this.lifeSpan,
    this.name,
    this.origin,
    this.temperament,
    this.weight,
  );

  factory BreedsModel.fromJsom(Map<String, dynamic> json) => _$BreedsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedsModelToJson(this);
}
