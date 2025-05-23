// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/dimension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dimension _$DimensionFromJson(Map<String, dynamic> json) => Dimension(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );

Map<String, dynamic> _$DimensionToJson(Dimension instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };
