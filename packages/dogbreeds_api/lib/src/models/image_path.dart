import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_path.g.dart';

@JsonSerializable()
class ImagePath extends Equatable {
  final String url;

  ImagePath(this.url);

  factory ImagePath.fromJson(Map<String, dynamic> json) =>
      _$ImagePathFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePathToJson(this);

  @override
  List<Object?> get props => [url];
}
