import 'dart:convert';

/// type : 2
/// id : 197864
/// country : "RU"
/// sunrise : 1651111556
/// sunset : 1651168004

Sys sysFromJson(String str) => Sys.fromJson(json.decode(str));
String sysToJson(Sys data) => json.encode(data.toJson());
class Sys {
  Sys({
      this.type, 
      this.id, 
      this.country, 
      this.sunrise, 
      this.sunset,});

  Sys.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['id'] = id;
    map['country'] = country;
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    return map;
  }

}