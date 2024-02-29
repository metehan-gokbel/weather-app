class WeatherModel {
  int temp;
  String description;
  int humidity;
  int windSpeed;
  String icon;
  String cityName;
  int minTemp;
  int maxTemp;


  WeatherModel({
    required this.temp,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.cityName,
    required this.minTemp,
    required this.maxTemp,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      temp: json['main']['temp'].toInt(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toInt(),
      windSpeed: json['wind']['speed'].toInt(),
      icon:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
      cityName: json['name'].split(RegExp(r'\s+'))[0],
      minTemp: json['main']['temp_min'].toInt(),
      maxTemp: json['main']['temp_max'].toInt(),
    );
  }
}
