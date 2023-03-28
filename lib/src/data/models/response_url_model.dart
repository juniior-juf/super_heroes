import 'package:super_heroes/src/domain/domain.dart';

class ResponseUrlModel extends UrlEntity {
  ResponseUrlModel({
    super.url,
    super.type,
  });

  factory ResponseUrlModel.fromJson(Map<String, dynamic> json) {
    return ResponseUrlModel(
      url: json['url'],
      type: json['type'],
    );
  }
}
