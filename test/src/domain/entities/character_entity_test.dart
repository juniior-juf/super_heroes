import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/src/domain/domain.dart';

void main() {
  group('CharacterEntity', () {
    test('should check all types of variables of the class', () {
      final entity = CharacterEntity(
        id: 0,
        name: '',
        description: '',
        modified: '',
        resourceUri: '',
        urls: <UrlEntity>[],
        thumbnail: ImageEntity(),
        comics: ResourceListEntity(),
        stories: ResourceListEntity(),
        events: ResourceListEntity(),
        series: ResourceListEntity(),
      );
      expect(entity.id.runtimeType, int);
      expect(entity.name.runtimeType, String);
      expect(entity.description.runtimeType, String);
      expect(entity.modified.runtimeType, String);
      expect(entity.resourceUri.runtimeType, String);
      expect(entity.urls.runtimeType, <UrlEntity>[].runtimeType);
      expect(entity.thumbnail.runtimeType, ImageEntity);
      expect(entity.comics.runtimeType, ResourceListEntity);
      expect(entity.stories.runtimeType, ResourceListEntity);
      expect(entity.events.runtimeType, ResourceListEntity);
      expect(entity.series.runtimeType, ResourceListEntity);
    });
  });
}
