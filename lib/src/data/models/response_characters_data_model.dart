import 'package:super_heroes/src/data/models/response_character_model.dart';
import 'package:super_heroes/src/domain/entities/character_data_entity.dart';

class ResponseCharactersDataModel extends CharacterDataEntity {
  ResponseCharactersDataModel({
    super.offset,
    super.limit,
    super.total,
    super.count,
    super.results,
  });

  factory ResponseCharactersDataModel.fromJson(Map<String, dynamic> json) {
    return ResponseCharactersDataModel(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      results: List.from(json['results'])
          .map((e) => ResponseCharacterModel.fromJson(e))
          .toList(),
    );
  }

  ResponseCharactersDataModel copyWith({
    int? offset,
    int? limit,
    int? total,
    int? count,
    List<ResponseCharacterModel>? results,
  }) {
    return ResponseCharactersDataModel(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      count: count ?? this.count,
      results: results ?? this.results,
    );
  }
}
