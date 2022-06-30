import 'dart:convert';

/// lon : 30.2642
/// lat : 59.8944

Coord coordFromJson(String str) => Coord.fromJson(json.decode(str));
String coordToJson(Coord data) => json.encode(data.toJson());
class Coord {
  Coord({
      this.lon, 
      this.lat,});

  Coord.fromJson(dynamic json) {
    lon = json['lon'];
    lat = json['lat'];
  }
  double? lon;
  double? lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lon'] = lon;
    map['lat'] = lat;
    return map;
  }

}