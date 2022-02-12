// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedsModel _$BreedsModelFromJson(Map<String, dynamic> json) => BreedsModel(
      json['bred_for'] as String?,
      json['height'] == null
          ? null
          : Height.fromJson(json['height'] as Map<String, dynamic>),
      json['id'] as int,
      Image.fromJson(json['image'] as Map<String, dynamic>),
      json['lifeSpan'] as String?,
      json['name'] as String,
      json['origin'] as String?,
      json['temperament'] as String?,
      Weight.fromJson(json['weight'] as Map<String, dynamic>),
    )
      ..breedGroup = json['breed_group'] as String?
      ..referenceImageId = json['reference_image_id'] as String?
      ..countryCode = json['country_code'] as String?;

Map<String, dynamic> _$BreedsModelToJson(BreedsModel instance) =>
    <String, dynamic>{
      'bred_for': instance.bredFor,
      'breed_group': instance.breedGroup,
      'height': instance.height?.toJson(),
      'id': instance.id,
      'image': instance.image.toJson(),
      'lifeSpan': instance.lifeSpan,
      'name': instance.name,
      'origin': instance.origin,
      'reference_image_id': instance.referenceImageId,
      'temperament': instance.temperament,
      'weight': instance.weight.toJson(),
      'country_code': instance.countryCode,
    };
