import 'package:super_heroes/src/domain/domain.dart';

class ResponseResourceListModel extends ResourceListEntity {
  ResponseResourceListModel({
    super.available,
    super.returned,
    super.collectionUri,
    super.items,
  });

  factory ResponseResourceListModel.fromJson(Map<String, dynamic> json) {
    return ResponseResourceListModel(
      available: json['available'],
      returned: json['returned'],
      collectionUri: json['collectionURI'],
      items: List.from(json['items'])
          .map((item) => ResponseItemsModel.fromJson(item))
          .toList(),
    );
  }
}

class ResponseItemsModel extends ItemsEntity {
  ResponseItemsModel({
    super.name,
    super.resourceUri,
    super.type,
  });

  factory ResponseItemsModel.fromJson(Map<String, dynamic> json) {
    return ResponseItemsModel(
      name: json['name'],
      resourceUri: json['resourceURI'],
      type: json['type'],
    );
  }
}
