import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/src/domain/entities/image_entity.dart';

void main() {
  group('ImageEntity', () {
    test('should check all types of variables of the class ', () {
      final entity = ImageEntity(path: '', extensionImage: '');
      expect(entity.path.runtimeType, String);
      expect(entity.extensionImage.runtimeType, String);
    });
  });
}
