// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'height.dart';
import 'weight.dart';

part 'breeds_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BreedsModel extends Equatable {
  BreedsModel(
    this.bredFor,
    this.height,
    this.id,
    this.lifeSpan,
    this.name,
    this.origin,
    this.temperament,
    this.weight,
    this.breedGroup,
    this.referenceImageId,
    this.countryCode,
  );

  factory BreedsModel.fromJsom(Map<String, dynamic> json) =>
      _$BreedsModelFromJson(json);
  @JsonKey(name: 'bred_for')
  final String? bredFor;
  @JsonKey(name: 'breed_group')
  final String? breedGroup;
  final Height? height;
  final int id;
  final String? lifeSpan;
  final String name;
  final String? origin;
  @JsonKey(name: 'reference_image_id')
  final String? referenceImageId;
  final String? temperament;
  final Weight weight;
  @JsonKey(name: 'country_code')
  final String? countryCode;

  Map<String, dynamic> toJson() => _$BreedsModelToJson(this);

  @override
  List<Object?> get props => [
        bredFor,
        breedGroup,
        height,
        id,
        lifeSpan,
        name,
        origin,
        referenceImageId,
        temperament,
        weight,
        countryCode,
      ];
}
