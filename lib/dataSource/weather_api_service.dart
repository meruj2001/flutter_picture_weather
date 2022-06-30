import 'package:dio/dio.dart';
import 'package:stroktrail/models/weather_model.dart';
import 'package:stroktrail/utils/constatns.dart';

class WeatherApiService {

  static Dio _dio() {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio.options.baseUrl = WEATHER_BASE_URL;
    dio.options.headers.addAll({
      "Content-Type":"application/json",
    });
    return dio;
  }

  static Future<WeatherModel> getWeather() async {
    const Map<String, String> queryParams = {
      "appid": "c35880b49ff95391b3a6d0edd0c722eb",
      "id": "616052",
      "lang": "en",
      "units": "metric"
    };
    const url = 'data/2.5/weather';
    final response = await _dio().get(url, queryParameters: queryParams);
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }
}
