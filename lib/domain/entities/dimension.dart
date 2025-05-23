import 'package:json_annotation/json_annotation.dart';
part '../entities_map_json/dimension.g.dart';
@JsonSerializable()
class Dimension {
   double? width;
   double? height;
   double? depth;

  Dimension({
    required this.width,
    required this.height,
    required this.depth,
  });
  factory Dimension.fromJson(Map<String, dynamic> json) => _$DimensionFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionToJson(this);

}
