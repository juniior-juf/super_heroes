import 'package:super_heroes/src/domain/use_cases/get_characters/params/character_params.dart';

class RequestCharacterParamsModel extends CharacterParams {
  RequestCharacterParamsModel({
    super.name,
    super.nameStartsWith,
    super.modifiedSince,
    super.orderBy,
    super.limit,
    super.offset,
    super.comics,
    super.series,
    super.stories,
    super.events,
  });

  factory RequestCharacterParamsModel.fromEntity(CharacterParams entity) {
    return RequestCharacterParamsModel(
      name: entity.name,
      nameStartsWith: entity.nameStartsWith,
      modifiedSince: entity.modifiedSince,
      comics: entity.comics,
      series: entity.series,
      events: entity.events,
      stories: entity.stories,
      orderBy: entity.orderBy,
      limit: entity.limit,
      offset: entity.offset,
    );
  }

  Map<String, dynamic> get toJson {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (nameStartsWith != null) map['nameStartsWith'] = nameStartsWith;
    if (modifiedSince != null) map['modifiedSince'] = modifiedSince;
    if (comics != null) map['comics'] = comics;
    if (series != null) map['series'] = series;
    if (events != null) map['events'] = events;
    if (stories != null) map['stories'] = stories;
    if (orderBy != null) map['orderBy'] = orderBy;
    if (limit != null) map['limit'] = limit;
    if (offset != null) map['offset'] = offset;
    return map;
  }
}
