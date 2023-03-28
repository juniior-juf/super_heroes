import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/domain/use_cases/get_characters/params/character_params.dart';

abstract class GetCharactersUseCase {
  Future<ResponseCharactersDataModel?> call(CharacterParams params);
}
