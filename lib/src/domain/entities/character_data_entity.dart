import 'package:super_heroes/src/domain/domain.dart';

class CharacterDataEntity {
  final int? offset;
  final int? limit;
  final int? total;
  final int? count;
  final List<CharacterEntity>? results;
  CharacterDataEntity({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });
}
