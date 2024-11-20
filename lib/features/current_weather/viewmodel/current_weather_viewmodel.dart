
import 'package:flutter/material.dart';
import 'package:my_weather/core/api/weather_api.dart';
import 'package:my_weather/core/models/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApi _weatherApi = WeatherApi();
  WeatherModel? _weather;
  String? _errorMessage;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String location) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherApi.fetchCurrentWeather(location);
    } catch (e) {
      _errorMessage = "Failed to load weather data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
