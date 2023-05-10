// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGroupModel _$ImageGroupModelFromJson(Map<String, dynamic> json) =>
    ImageGroupModel(
      json['total_pages'] as int,
      (json['data'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e.cast<String, dynamic>()))
          .toList(),
    );

Map<String, dynamic> _$ImageGroupModelToJson(ImageGroupModel instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'data': instance.images,
    };
