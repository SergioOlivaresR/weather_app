import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('21105f77f2fe4fed82f123319242204');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    print(mainCondition);
    if (mainCondition ==  null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'sunny':
        return 'assets/sunny.json';
      case 'clear':
        return 'assets/clear.json';
      case 'partly cloudy':
        return 'assets/partly_cloudy.json';
      case 'cloudy':
      case 'overcast':
      case 'mist':
        return 'assets/cloudy.json';
      case 'patchy rain possible':
      case 'Patchy light rain':
      case 'Light rain':
      case 'Moderate rain at times':
      case 'Moderate rain':
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Light freezing rain':
      case 'Moderate or heavy freezing rain"':
      case 'light rain shower':
      case 'moderate or heavy rain shower':
      case 'torrential rain shower':
      case 'patchy light rain with thunder':
      case 'moderate or heavy rain with thunder':
        return 'assets/rain.json';
      case 'patchy snow possible':
      case 'patchy sleet possible':
      case 'patchy freezing drizzle possible':
      case 'thundery outbreaks possible':
      case 'blowing snow':
      case 'blizzard':
      case 'fog':
      case 'freezing fog':
      case 'Patchy light drizzle':
      case 'Light drizzle':
      case 'Freezing drizzle':
      case 'Heavy freezing drizzle':
      case 'Light sleet':
      case 'Moderate or heavy sleet':
      case 'Patchy light snow':
      case 'Light snow':
      case 'Patchy moderate snow':
      case 'Moderate snow':
      case 'Patchy heavy snow':
      case 'Heavy snow':
      case 'ice pellets':
      case 'light sleet showers':
      case 'moderate or heavy sleet showers':
      case 'light snow showers':
      case 'moderate or heavy snow showers':
      case 'light showers of ice pellets':
      case 'moderate or heavy showers of ice pellets':
      case 'patchy light snow with thunder':
      case 'moderate or heavy snow with thunder':
      default:
        return 'assets/sunny.json';
    }
  }

  void reload() {
    _fetchWeather();
  }
  // init state
  @override
  void initState() {
    super.initState();

    // fetch on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city...'),
            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            // temperature
            Text('${_weather?.temperature.round()}°C'),
            // reload
            TextButton(
              onPressed: () { reload(); },
              child: const Text('reload...')
            )
          ],
        ),
      ),
    );
  }
}