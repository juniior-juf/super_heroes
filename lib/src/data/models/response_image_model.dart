import 'package:super_heroes/src/domain/domain.dart';

class ResponseImageModel extends ImageEntity {
  ResponseImageModel({
    super.path,
    super.extensionImage,
  });

  factory ResponseImageModel.fromJson(Map<String, dynamic> json) {
    return ResponseImageModel(
      path: json['path'],
      extensionImage: json['extension'],
    );
  }
}
