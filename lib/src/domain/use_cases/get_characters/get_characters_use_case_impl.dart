import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/domain/domain.dart';

class GetCharactersUseCaseImpl extends GetCharactersUseCase {
  final CharactersRepository _repository;

  GetCharactersUseCaseImpl(this._repository);
  @override
  Future<ResponseCharactersDataModel?> call(CharacterParams params) async {
    return await _repository.getCharacters(params);
  }
}
