import 'package:json_annotation/json_annotation.dart';
import 'package:test_yaho/models/image_model.dart';

part 'image_group_model.g.dart';

@JsonSerializable()
class ImageGroupModel {
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'data')
  final List<ImageModel> images;

  ImageGroupModel(
    this.totalPages,
    this.images,
  );

  factory ImageGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ImageGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageGroupModelToJson(this);
}
