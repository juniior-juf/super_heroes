import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/src/data/models/response_characters_data_model.dart';
import 'package:super_heroes/src/domain/domain.dart';
import 'package:super_heroes/src/domain/use_cases/get_characters/get_characters_use_case_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_characters_use_case_test.mocks.dart';

@GenerateMocks([CharactersRepository])
void main() {
  late CharactersRepository repository;
  late GetCharactersUseCase useCase;
  late String data;
  late Map<String, dynamic> jsonData;

  setUp(() async {
    repository = MockCharactersRepository();
    useCase = GetCharactersUseCaseImpl(repository);
    data = await File('data.json').readAsString();
    jsonData = json.decode(data);
  });

  group('GetChatactersUsecase', () {
    test(
        'should return a list of all characters when the limit not is specified',
        () async {
      const total = 100;
      final params = CharacterParams();
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer((_) async => response);

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(total));
      expect(result?.results?.length, total);
    });

    test(
        'should return a list with the equivalent amount when the character limit is specified',
        () async {
      const total = 100;
      const limit = 25;
      final params = CharacterParams(limit: limit);
      jsonData['data']['limit'] = limit;
      jsonData['data']['count'] = limit;
      jsonData['data']['results'] =
          List.from(jsonData['data']['results']).sublist(0, limit);
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer(
        (_) async => response,
      );

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(limit));
      expect(result?.results?.length, limit);
      expect(result?.results?.first.id, equals(1011334));
      expect(result?.results?.last.id, equals(1009240));
    });

    test(
        'should return a list with the equivalent amount when the character limit is specified and offset value is set',
        () async {
      const total = 100;
      const limit = 25;
      const offset = 25;
      final params = CharacterParams(limit: limit, offset: offset);
      jsonData['data']['limit'] = limit;
      jsonData['data']['count'] = offset;
      jsonData['data']['results'] = List.from(jsonData['data']['results'])
          .sublist(offset, offset + limit);
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer(
        (_) async => response,
      );

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(limit));
      expect(result?.results?.length, limit);
      expect(result?.results?.first.id, equals(1011120));
      expect(result?.results?.last.id, equals(1017574));
    });

    test(
        'should return a list with the equivalent amount when name is specified',
        () async {
      const total = 6;
      const count = 6;

      const name = 'ag';
      final params = CharacterParams(name: 'ag');
      jsonData['data']['total'] = total;
      jsonData['data']['count'] = count;
      jsonData['data']['results'] =
          List.from(jsonData['data']['results']).where(
        (element) => element['name'].toString().toLowerCase().startsWith(name),
      );
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer(
        (_) async => response,
      );

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(count));
      expect(result?.results?.length, total);
      expect(result?.results?.first.id, equals(1012717));
      expect(result?.results?.last.id, equals(1011175));
    });

    test(
        'should return a list with the equivalent amount when name and limit is specified',
        () async {
      const total = 6;
      const count = 3;
      const limit = 3;
      const name = 'ag';
      final params = CharacterParams(name: 'ag');
      jsonData['data']['total'] = total;
      jsonData['data']['count'] = count;
      jsonData['data']['limit'] = limit;

      jsonData['data']['results'] = List.from(jsonData['data']['results'])
          .where((element) =>
              element['name'].toString().toLowerCase().startsWith(name))
          .toList()
          .sublist(0, limit);
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer(
        (_) async => response,
      );

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(count));
      expect(result?.limit, equals(limit));
      expect(result?.results?.length, limit);
      expect(result?.results?.first.id, equals(1012717));
      expect(result?.results?.last.id, equals(1011031));
    });

    test(
        'should return a list with the equivalent amount when name, limit and offset is specified',
        () async {
      const total = 6;
      const count = 3;
      const limit = 3;
      const offset = 3;
      const name = 'ag';
      final params = CharacterParams(name: 'ag');
      jsonData['data']['total'] = total;
      jsonData['data']['count'] = count;
      jsonData['data']['limit'] = limit;
      jsonData['data']['offset'] = offset;
      jsonData['data']['results'] = List.from(jsonData['data']['results'])
          .where((element) =>
              element['name'].toString().toLowerCase().startsWith(name))
          .toList()
          .sublist(offset, offset + limit);
      final response = ResponseCharactersDataModel.fromJson(jsonData['data']);

      when(repository.getCharacters(params)).thenAnswer(
        (_) async => response,
      );

      final result = await useCase(params);

      verify(repository.getCharacters(params)).called(1);
      expect(result, isA<ResponseCharactersDataModel>());
      expect(result?.total, equals(total));
      expect(result?.count, equals(count));
      expect(result?.limit, equals(limit));
      expect(result?.offset, equals(offset));
      expect(result?.results?.length, limit);
      expect(result?.results?.first.id, equals(1009150));
      expect(result?.results?.last.id, equals(1011175));
    });
  });
}
