// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      rating: ((json['rating'] ?? 0) as num).toInt(),
      comment: json['comment'] as String,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      reviewerName: json['reviewerName'] as String,
      reviewerEmail: json['reviewerEmail'] as String,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'date': instance.date?.toIso8601String(),
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
    };
