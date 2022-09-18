import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'height.dart';
import 'image.dart';
import 'weight.dart';

part 'breeds_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class BreedsModel extends Equatable {
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

  factory BreedsModel.fromJsom(Map<String, dynamic> json) =>
      _$BreedsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedsModelToJson(this);

  @override
  List<Object?> get props => [
        bredFor,
        breedGroup,
        height,
        id,
        image,
        lifeSpan,
        name,
        origin,
        referenceImageId,
        temperament,
        weight,
        countryCode,
      ];
}
