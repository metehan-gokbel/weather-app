import 'package:dio/dio.dart';

import '../utils/api.dart';

class WeatherApiProvider {
  final Dio _dio = Dio();
  var apiKey = Constants.apiKey;

  Future<dynamic> getWeatherData(cityName) async {
    var response = await _dio
        .get('${Constants.baseUrl}/data/2.5/weather', queryParameters: {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    });

    return response;
  }
}
