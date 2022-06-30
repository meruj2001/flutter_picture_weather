import 'dart:convert';

/// speed : 4
/// deg : 240

Wind windFromJson(String str) => Wind.fromJson(json.decode(str));
String windToJson(Wind data) => json.encode(data.toJson());
class Wind {
  Wind({
      this.speed, 
      this.deg,});

  Wind.fromJson(dynamic json) {
    speed = json['speed'];
    deg = json['deg'];
  }
  dynamic speed;
  dynamic deg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['speed'] = speed;
    map['deg'] = deg;
    return map;
  }

}