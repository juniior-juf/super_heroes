import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/src/domain/entities/resource_list_entity.dart';

void main() {
  group('ResourceListEntity', () {
    test('should check all types of variables of the class', () {
      final entity = ResourceListEntity(
        available: 0,
        returned: 0,
        collectionUri: '',
        items: [ItemsEntity()],
      );
      expect(entity.available.runtimeType, int);
      expect(entity.returned.runtimeType, int);
      expect(entity.collectionUri.runtimeType, String);
      expect(entity.items.runtimeType, List<ItemsEntity>);
    });
  });
}
