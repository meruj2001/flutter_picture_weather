import 'package:dio/dio.dart';
import 'package:stroktrail/models/picture_model.dart';
import 'package:stroktrail/utils/constatns.dart';

class PictureApiService {
  static final _dio = createDioInstance();

  static Dio createDioInstance() {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio.options.baseUrl = PICTURE_BASE_URL;
    return dio;
  }

  static Future<List<PictureModel>> getPictures(int page, int count) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": count.toString()
    };
    const url = "v2/list";
    final response = await _dio.get(url, queryParameters: queryParams);
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      List<dynamic> result = response.data;
      final data = result.map((e) => PictureModel.fromMap(e)).toList();
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
