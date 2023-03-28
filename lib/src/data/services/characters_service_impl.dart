import 'package:super_heroes/src/data/models/request_charaters_params_model.dart';
import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/data/services/characters_service.dart';
import 'package:super_heroes/src/infra/http/http_client.dart';

class CharactersServiceImpl extends CharactersService {
  final HttpClient _clientHttp;

  CharactersServiceImpl(this._clientHttp);

  @override
  Future<ResponseCharactersDataModel?> getCharacters(
    RequestCharacterParamsModel request,
  ) async {
    return await _clientHttp.request(
      method: HttpMethod.get,
      version: 'v1/',
      path: 'public/characters',
      queryParams: request.toJson,
      fromJson: (json) => ResponseCharactersDataModel.fromJson(json['data']),
    );
  }
}
