import 'dart:convert';

PictureModel pictureModelFromJson(String str) => PictureModel.fromJson(str);

String pictureModelToJson(PictureModel data) => json.encode(data.toJson());

class PictureModel {
  PictureModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  static PictureModel fromJson(String jsonStr) {
    final json = jsonDecode(jsonStr);
    return PictureModel(
      id: json["id"],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      downloadUrl: json['download_url'],
    );
  }

  static PictureModel fromMap(Map map) {
    return PictureModel(
      id: map["id"],
      author: map['author'],
      width: map['width'],
      height: map['height'],
      url: map['url'],
      downloadUrl: map['download_url'],
    );
  }

  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['author'] = author;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    map['download_url'] = downloadUrl;
    return map;
  }
}
