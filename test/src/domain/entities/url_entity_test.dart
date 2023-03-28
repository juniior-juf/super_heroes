import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/src/domain/entities/url_entity.dart';

void main() {
  group('UrlEntity', () {
    test('should check all types of variables of the class ', () {
      final entity = UrlEntity(type: '', url: '');
      expect(entity.type.runtimeType, String);
      expect(entity.url.runtimeType, String);
    });
  });
}
