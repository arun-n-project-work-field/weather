import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_assignment/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_assignment/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          'assets/1.png',
          scale: 1,
        );
      case >= 300 && < 400:
        return Image.asset(
          'assets/2.png',
          scale: 1,
        );
      case >= 500 && < 600:
        return Image.asset(
          'assets/3.png',
          scale: 1,
        );
      case >= 600 && < 700:
        return Image.asset(
          'assets/4.png',
          scale: 1,
        );
      case >= 700 && < 800:
        return Image.asset(
          'assets/5.png',
          scale: 1,
        );
      case == 800:
        return Image.asset(
          'assets/6.png',
          scale: 1,
        );
      case > 800 && <= 804:
        return Image.asset(
          'assets/7.png',
          scale: 1,
        );
      default:
        return Image.asset(
          'assets/7.png',
          scale: 8,
        );
    }
  }

  var hourNow = int.parse(DateFormat('kk').format(DateTime.now()));
  String greeting = "";

  @override
  Widget build(BuildContext context) {
    if ((hourNow >= 1) && (hourNow < 12)) {
      greeting = 'Good Morning!';
    } else if ((hourNow >= 12) && (hourNow <= 16)) {
      greeting = 'Good Afternoon!';
    } else if ((hourNow > 16) && (hourNow < 20)) {
      greeting = 'Good Evening!';
    } else if ((hourNow >= 20) && (hourNow < 24)) {
      greeting = 'Good Night!';
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: SizeConfig.heightMultiplier * 40,
                  width: SizeConfig.screenWidth * 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: SizeConfig.heightMultiplier * 40,
                  width: SizeConfig.screenWidth * 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: SizeConfig.heightMultiplier * 30,
                  width: SizeConfig.screenWidth * 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFAB40),
                  ),
                ),
              ),
              // blur filter on top of the colors
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${state.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 0.2),
                          Text(
                            greeting,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.textMultiplier * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 8,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 3,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 0.2),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd •')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 0.4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/11.png',
                                    scale: 8,
                                  ),
                                  SizedBox(width: SizeConfig.widthMultiplier),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunrise',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.widthMultiplier),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/12.png',
                                    scale: 8,
                                  ),
                                  SizedBox(width: SizeConfig.widthMultiplier),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.widthMultiplier),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Image.asset(
                                  'assets/13.png',
                                  scale: 8,
                                ),
                                SizedBox(width: SizeConfig.widthMultiplier),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temp Max',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(width: SizeConfig.widthMultiplier),
                                    Text(
                                      "${state.weather.tempMax!.celsius!.round()} °C",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ]),
                              Row(children: [
                                Image.asset(
                                  'assets/14.png',
                                  scale: 8,
                                ),
                                SizedBox(width: SizeConfig.widthMultiplier),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temp Min',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(width: SizeConfig.widthMultiplier),
                                    Text(
                                      "${state.weather.tempMin!.celsius!.round()} °C",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ])
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
