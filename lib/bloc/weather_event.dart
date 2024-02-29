abstract class WeatherEvent {}

class LoadWeatherEvent extends WeatherEvent {
  String city;

  LoadWeatherEvent(this.city);
}
