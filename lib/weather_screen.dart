import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/weather_bloc.dart';
import 'bloc/weather_event.dart';
import 'bloc/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<WeatherBloc>(context).add(LoadWeatherEvent('İzmir'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF7986cb),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          key: const Key('searchField'),
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Search city by name",
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onSubmitted: (String value) {
                            _search(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF7986cb),
                        child: IconButton(
                          onPressed: () {
                            _search(context);
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherInit) {
                        return Container();
                      }
                      if (state is WeatherLoading) {
                        return const CircularProgressIndicator();
                      }
                      if (state is WeatherResponse) {
                        return state.either.fold(
                          (errorMessage) {
                            return Column(
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 120,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  errorMessage,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                          (weather) {
                            return Column(
                              children: [
                                Text(
                                  weather.cityName,
                                  style: TextStyle(
                                    fontSize: 42.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.temp.toString(),
                                      style: TextStyle(
                                        fontSize: 56.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Image.network(
                                  weather.icon,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  weather.description.capitalize(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildInfoWidget(
                                        Icons.water_drop,
                                        Colors.indigo,
                                        '${weather.humidity}%',
                                        'Humidity'),
                                    _buildInfoWidget(
                                        Icons.air,
                                        Colors.indigo,
                                        '${weather.windSpeed}Km/h',
                                        'Wind Speed'),
                                  ],
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildInfoWidget(
                                        Icons.thermostat_outlined,
                                        Colors.red,
                                        '${weather.maxTemp.toString()} °C',
                                        'Max'),
                                    _buildInfoWidget(
                                        Icons.thermostat_outlined,
                                        Colors.white54,
                                        '${weather.minTemp.toString()} °C',
                                        'Min'),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  void _search(BuildContext context) {
    if (controller.text != '') {
      BlocProvider.of<WeatherBloc>(context)
          .add(LoadWeatherEvent(controller.text));
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }
}



Widget _buildInfoWidget(
    IconData icon, Color color, String humidity, String label) {
  return SizedBox(
    child: Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(
          width: 4.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              humidity,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
