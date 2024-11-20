import 'package:flutter/material.dart';
import 'package:my_weather/core/models/weather_model.dart';
import 'package:provider/provider.dart';
import '../viewmodel/current_weather_viewmodel.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = context.watch<WeatherViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final location = _locationController.text;
                    if (location.isNotEmpty) {
                      weatherViewModel.fetchWeather(location);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (weatherViewModel.isLoading)
              Center(child: CircularProgressIndicator())
            else if (weatherViewModel.errorMessage != null)
              Text(
                weatherViewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              )
            else if (weatherViewModel.weather != null)
              WeatherDetails(weather: weatherViewModel.weather!),
          ],
        ),
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location: ${weather.locationName}, ${weather.country}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text("Temperature: ${weather.temperature}°C"),
        Text("Condition: ${weather.condition}"),
        Text("Feels Like: ${weather.feelsLike}°C"),
        Text("Humidity: ${weather.humidity}%"),
        Text("Wind Speed: ${weather.windSpeed} km/h"),
        Image.network(weather.conditionIcon),
      ],
    );
  }
}
