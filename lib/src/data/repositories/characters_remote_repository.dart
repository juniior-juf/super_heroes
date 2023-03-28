import 'package:super_heroes/src/data/models/request_charaters_params_model.dart';
import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/data/services/characters_service.dart';
import 'package:super_heroes/src/domain/repositories/repositories.dart';
import 'package:super_heroes/src/domain/use_cases/get_characters/params/character_params.dart';

class CharactersRemoteRepository extends CharactersRepository {
  final CharactersService _service;

  CharactersRemoteRepository(this._service);
  @override
  Future<ResponseCharactersDataModel?> getCharacters(
    CharacterParams params,
  ) async {
    return await _service.getCharacters(
      RequestCharacterParamsModel.fromEntity(params),
    );
  }
}
