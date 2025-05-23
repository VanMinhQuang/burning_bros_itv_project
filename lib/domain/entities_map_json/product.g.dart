// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: ((json['id'] ?? 0) as num).toInt(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      dimensions: json['dimensions'] != null
          ? Dimension.fromJson(json['dimensions'] as Map<String, dynamic>)
          : Dimension(),
      warrantyInformation: json['warrantyInformation']  ?? '',
      shippingInformation: json['shippingInformation']  ?? '',
      availabilityStatus: json['availabilityStatus']  ?? '',
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
          : Meta(),
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      thumbnail: json['thumbnail'] ?? '',
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'tags': instance.tags,
      'brand': instance.brand,
      'sku': instance.sku,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'warrantyInformation': instance.warrantyInformation,
      'shippingInformation': instance.shippingInformation,
      'availabilityStatus': instance.availabilityStatus,
      'reviews': instance.reviews,
      'returnPolicy': instance.returnPolicy,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      'meta': instance.meta,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
    };
