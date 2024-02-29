import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/data/weather_repository.dart';
import 'package:weather/model/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInit()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      Either<String, WeatherModel> either =
          await repository.fetchWeatherData(event.city);
      emit(WeatherResponse(either));
    });
  }
}
