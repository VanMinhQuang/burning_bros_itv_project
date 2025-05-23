import 'package:json_annotation/json_annotation.dart';
part '../entities_map_json/review.g.dart';
@JsonSerializable()
class Review {
   int? rating;
   String? comment;
   DateTime? date;
   String? reviewerName;
   String? reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

}