import 'package:super_heroes/src/domain/entities/image_entity.dart';
import 'package:super_heroes/src/domain/entities/resource_list_entity.dart';
import 'package:super_heroes/src/domain/entities/url_entity.dart';

class CharacterEntity {
  final int? id;
  final String? name;
  final String? description;
  final String? modified;
  final String? resourceUri;
  final List<UrlEntity>? urls;
  final ImageEntity? thumbnail;
  final ResourceListEntity? comics;
  final ResourceListEntity? stories;
  final ResourceListEntity? events;
  final ResourceListEntity? series;

  CharacterEntity({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.resourceUri,
    this.urls,
    this.thumbnail,
    this.comics,
    this.stories,
    this.events,
    this.series,
  });
}
