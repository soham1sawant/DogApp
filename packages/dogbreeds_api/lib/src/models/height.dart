import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'height.g.dart';

@JsonSerializable()
class Height extends Equatable {

  const Height(this.imperial, this.metric);

  factory Height.fromJson(Map<String, dynamic> json) => _$HeightFromJson(json);
  final String imperial;
  final String metric;

  Map<String, dynamic> toJson() => _$HeightToJson(this);

  @override
  List<Object?> get props => [imperial, metric];
}
