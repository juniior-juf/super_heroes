class CharacterParams {
  final String? name;
  final String? nameStartsWith;
  final String? modifiedSince;
  final int? comics;
  final int? series;
  final int? events;
  final int? stories;
  final String? orderBy;
  final int? limit;
  final int? offset;
  CharacterParams({
    this.name,
    this.nameStartsWith,
    this.modifiedSince,
    this.comics,
    this.series,
    this.events,
    this.stories,
    this.orderBy,
    this.limit,
    this.offset,
  });
}
