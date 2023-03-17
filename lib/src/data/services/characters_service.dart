import 'package:super_heroes/src/data/models/request_charaters_params_model.dart';
import 'package:super_heroes/src/data/models/response_characters_data_model.dart';

abstract class CharactersService {
  Future<ResponseCharactersDataModel?> getCharacters(
    RequestCharacterParamsModel request,
  );
}
