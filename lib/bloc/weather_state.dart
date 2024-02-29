import 'package:dartz/dartz.dart';
import 'package:weather/model/weather_model.dart';

abstract class WeatherState {}

class WeatherInit extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherResponse extends WeatherState {
  Either<String, WeatherModel> either;

  WeatherResponse(this.either);
}
