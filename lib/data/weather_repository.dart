import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather/data/weather_api_provider.dart';
import 'package:weather/model/weather_model.dart';

class WeatherRepository {
  WeatherApiProvider apiProvider = WeatherApiProvider();

  Future<Either<String, WeatherModel>> fetchWeatherData(String cityName) async {
    try {
      Response response = await apiProvider.getWeatherData(cityName);

      if (response.statusCode == 200) {
        WeatherModel weather = WeatherModel.fromJson(response.data);

        return right(weather);
      } else {
        return left('Invalid location.');
      }
    } catch (e) {
      return left('Invalid location.');
    }
  }
}
