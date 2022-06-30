import 'coord.dart';
import 'weather.dart';
import 'weather_main.dart';
import 'wind.dart';
import 'clouds.dart';
import 'sys.dart';
import 'dart:convert';

/// coord : {"lon":30.2642,"lat":59.8944}
/// weather : [{"id":802,"main":"Clouds","description":"переменная облачность","icon":"03d"}]
/// base : "stations"
/// main : {"temp":3.26,"feels_like":-0.28,"temp_min":2.81,"temp_max":4.08,"pressure":1021,"humidity":57}
/// visibility : 10000
/// wind : {"speed":4,"deg":240}
/// clouds : {"all":40}
/// dt : 1651131737
/// sys : {"type":2,"id":197864,"country":"RU","sunrise":1651111556,"sunset":1651168004}
/// timezone : 10800
/// id : 498817
/// name : "Санкт-Петербург"
/// cod : 200

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));
String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());
class WeatherModel {
  WeatherModel({
      this.coord, 
      this.weather, 
      this.base, 
      this.main, 
      this.visibility, 
      this.wind, 
      this.clouds, 
      this.dt, 
      this.sys, 
      this.timezone, 
      this.id, 
      this.name, 
      this.cod,});

  WeatherModel.fromJson(dynamic json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coord != null) {
      map['coord'] = coord?.toJson();
    }
    if (weather != null) {
      map['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    map['base'] = base;
    if (main != null) {
      map['main'] = main?.toJson();
    }
    map['visibility'] = visibility;
    if (wind != null) {
      map['wind'] = wind?.toJson();
    }
    if (clouds != null) {
      map['clouds'] = clouds?.toJson();
    }
    map['dt'] = dt;
    if (sys != null) {
      map['sys'] = sys?.toJson();
    }
    map['timezone'] = timezone;
    map['id'] = id;
    map['name'] = name;
    map['cod'] = cod;
    return map;
  }

}