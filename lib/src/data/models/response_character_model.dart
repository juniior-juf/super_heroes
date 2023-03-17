import 'package:super_heroes/src/data/models/response_image_model.dart';
import 'package:super_heroes/src/data/models/response_resource_list_model.dart';
import 'package:super_heroes/src/data/models/response_url_model.dart';
import 'package:super_heroes/src/domain/domain.dart';

class ResponseCharacterModel extends CharacterEntity {
  ResponseCharacterModel({
    super.id,
    super.name,
    super.description,
    super.modified,
    super.resourceUri,
    super.urls,
    super.thumbnail,
    super.comics,
    super.series,
    super.stories,
    super.events,
  });

  factory ResponseCharacterModel.fromJson(Map<String, dynamic> json) {
    return ResponseCharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      modified: json['modified'],
      resourceUri: json['resourceURI'],
      urls: List.from(json['urls'])
          .map((e) => ResponseUrlModel.fromJson(e))
          .toList(),
      thumbnail: ResponseImageModel.fromJson(json['thumbnail']),
      comics: ResponseResourceListModel.fromJson(json['comics']),
      series: ResponseResourceListModel.fromJson(json['series']),
      stories: ResponseResourceListModel.fromJson(json['stories']),
      events: ResponseResourceListModel.fromJson(json['events']),
    );
  }
}
