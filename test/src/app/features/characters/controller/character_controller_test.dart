import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_heroes/src/app/features/characters/controller/character_controller.dart';
import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/domain/domain.dart';

import 'character_controller_test.mocks.dart';

@GenerateMocks([GetCharactersUseCase])
void main() {
  late GetCharactersUseCase useCase;
  late CharacterController controller;
  late String data;
  late Map<String, dynamic> jsonData;

  setUp(() async {
    useCase = MockGetCharactersUseCase();
    controller = CharacterController(getCharactersUseCase: useCase);
    data = await File('data.json').readAsString();
  });

  group('CharacterController', () {
    test('should add the first characters when limit is defined', () async {
      const limit = 25;
      const offset = 0;

      final params = CharacterParams(limit: limit, offset: offset);
      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      jsonData['data']['results'] = List.from(
        jsonData['data']['results'],
      ).sublist(offset, limit);

      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharacters(params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(25));
      expect(controller.allCharacters?.length, equals(25));
    });

    test('should add to list of characters when method is called twice',
        () async {
      const limit = 25;
      const offset = 0;

      var params = CharacterParams(limit: limit, offset: offset);
      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      jsonData['data']['results'] = List.from(
        jsonData['data']['results'],
      ).sublist(offset, limit);

      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharacters(params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(25));
      expect(controller.allCharacters?.length, equals(25));

      params = CharacterParams(
        limit: limit,
        offset: controller.allCharacters!.length + limit,
      );

      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      jsonData['data']['results'] = List.from(
        jsonData['data']['results'],
      ).sublist(
        controller.allCharacters!.length,
        controller.allCharacters!.length + limit,
      );

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharacters(firstRequest: false, params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(25));
      expect(controller.allCharacters?.length, equals(50));
    });
  });

  group('CharacterController', () {
    test('should add the first characters when character name starts with',
        () async {
      const limit = 6;
      const offset = 0;
      const name = 'ag';

      final params = CharacterParams(limit: limit, offset: offset, name: name);
      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      final resultsStartWithName = List.from(jsonData['data']['results']).where(
        (result) => result['name'].toString().toLowerCase().startsWith(name),
      );
      jsonData['data']['results'] =
          resultsStartWithName.toList().sublist(offset, limit);

      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharactersByName(params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(limit));
      expect(controller.filteredCharacters?.length, equals(limit));
    });

    test(
        'should add to list of characters when method is called twice and that the name starts with',
        () async {
      const limit = 3;
      const offset = 0;
      const name = 'ag';

      var params = CharacterParams(
        limit: limit,
        offset: offset,
        name: name,
      );

      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      final resultsStartWithName = List.from(jsonData['data']['results']).where(
        (result) => result['name'].toString().toLowerCase().startsWith(name),
      );
      jsonData['data']['results'] =
          resultsStartWithName.toList().sublist(offset, limit);

      var response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharactersByName(params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(3));
      expect(controller.filteredCharacters?.length, equals(3));

      params = CharacterParams(
        limit: limit,
        offset: controller.filteredCharacters!.length + limit,
        name: name,
      );

      jsonData = json.decode(data);
      jsonData['data']['count'] = limit;
      jsonData['data']['results'] = resultsStartWithName.toList().sublist(
          controller.filteredCharacters!.length,
          controller.filteredCharacters!.length + limit);

      response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(useCase.call(params)).thenAnswer((_) async => response);
      await controller.getCharactersByName(firstRequest: false, params: params);

      verify(useCase.call(params)).called(1);
      expect(controller.characterData?.count, equals(limit));
      expect(controller.filteredCharacters?.length, equals(6));
    });
  });
}
