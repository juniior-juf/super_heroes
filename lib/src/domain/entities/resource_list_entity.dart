class ResourceListEntity {
  final int? available;
  final int? returned;
  final String? collectionUri;
  final List<ItemsEntity>? items;

  ResourceListEntity({
    this.available,
    this.returned,
    this.collectionUri,
    this.items,
  });
}

class ItemsEntity {
  final String? name;
  final String? resourceUri;
  final String? type;

  ItemsEntity({
    this.name,
    this.resourceUri,
    this.type,
  });
}
