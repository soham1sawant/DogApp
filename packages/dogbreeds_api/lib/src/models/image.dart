import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image extends Equatable {

  const Image(this.id, this.width, this.height, this.url);

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  final String id;
  final int width;
  final int height;
  final String url;

  Map<String, dynamic> toJson() => _$ImageToJson(this);

  @override
  List<Object?> get props => [id, width, height, url];
}
