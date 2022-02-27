import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'height.g.dart';

@JsonSerializable()
class Height extends Equatable {
  final String imperial;
  final String metric;

  const Height(this.imperial, this.metric);

  factory Height.fromJson(Map<String, dynamic> json) => _$HeightFromJson(json);

  Map<String, dynamic> toJson() => _$HeightToJson(this);

  @override
  List<Object?> get props => [imperial, metric];
}
