import 'package:json_annotation/json_annotation.dart';

part 'height.g.dart';

@JsonSerializable()
class Height {
  final String imperial;
  final String metric;

  Height(this.imperial, this.metric);

  factory Height.fromJson(Map<String, dynamic> json) => _$HeightFromJson(json);

  Map<String, dynamic> toJson() => _$HeightToJson(this);
}
