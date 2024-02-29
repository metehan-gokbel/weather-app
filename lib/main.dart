import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data/weather_repository.dart';
import 'package:weather/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocProvider(
            create: (context) => WeatherBloc(WeatherRepository()),
            child: const WeatherScreen(),
          ),
        ));
  }
}
