import 'package:dio/dio.dart';
import 'api_config.dart';
import '../models/weather_model.dart';

class WeatherApi {
  final Dio _dio = Dio();

  WeatherApi() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5); 
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  /// 获取当前天气
  Future<WeatherModel> fetchCurrentWeather(String location) async {
    try {
      final response = await _dio.get(
        "/current.json",
        queryParameters: {
          "key": ApiConfig.apiKey,
          "q": location,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      throw Exception("Error fetching current weather: $e");
    }
  }
}
