import 'package:json_annotation/json_annotation.dart';
part '../entities_map_json/meta.g.dart';
@JsonSerializable()
class Meta {
   DateTime? createdAt;
   DateTime? updatedAt;
   String? barcode;
   String? qrCode;

  Meta({
     this.createdAt,
     this.updatedAt,
     this.barcode,
     this.qrCode,
  });
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

}