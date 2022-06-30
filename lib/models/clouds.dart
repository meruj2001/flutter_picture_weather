import 'dart:convert';

/// all : 40

Clouds cloudsFromJson(String str) => Clouds.fromJson(json.decode(str));
String cloudsToJson(Clouds data) => json.encode(data.toJson());
class Clouds {
  Clouds({
      this.all,});

  Clouds.fromJson(dynamic json) {
    all = json['all'];
  }
  int? all;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['all'] = all;
    return map;
  }

}