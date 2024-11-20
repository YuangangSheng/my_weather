class WeatherModel {
  final String locationName;
  final String country;
  final String condition;
  final String conditionIcon;
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final int humidity;

  WeatherModel({
    required this.locationName,
    required this.country,
    required this.condition,
    required this.conditionIcon,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final current = json['current'];

    return WeatherModel(
      locationName: location['name'],
      country: location['country'],
      condition: current['condition']['text'],
      conditionIcon: "https:${current['condition']['icon']}",
      temperature: current['temp_c'],
      feelsLike: current['feelslike_c'],
      windSpeed: current['wind_kph'],
      humidity: current['humidity'],
    );
  }
}
