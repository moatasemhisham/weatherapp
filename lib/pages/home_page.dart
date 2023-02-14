import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import '../cubits/weather_cubit.dart';
import '';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccess) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SuccessBody(weatherData: weatherData!);
          } else if (state is WeatherFailure) {
            return const Center(
              child: Text('There is no weather data, pleas try again'),
            );
          } else {
            return const Center(
              child: Text('Search for the weather'),
            );
          }
        },
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData!.getThemeColor(),
            weatherData!.getThemeColor()[300]!,
            weatherData!.getThemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            Provider.of<WeatherProvider>(context).cityName!,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                weatherData!.temp.toInt().toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            weatherData!.weatherStateName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
// BlocProvider<SubjectBloc>(
// create: (context) => SubjectBloc(),
// child:     Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// weatherData!.getThemeColor(),
// weatherData!.getThemeColor()[300]!,
// weatherData!.getThemeColor()[100]!,
// ],
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// ),),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Spacer(
// flex: 3,
// ),
// Text(
// Provider.of<WeatherProvider>(context).cityName!,
// style: TextStyle(
// fontSize: 32,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// 'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
// style: TextStyle(
// fontSize: 22,
// ),
// ),
// Spacer(),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Image.asset(weatherData!.getImage()),
// Text(
// weatherData!.temp.toInt().toString(),
// style: TextStyle(
// fontSize: 32,
// fontWeight: FontWeight.bold,
// ),
// ),
// Column(
// children: [
// Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
// Text('minTemp : ${weatherData!.minTemp.toInt()}'),
// ],
// ),
// ],
// ),
// Spacer(),
// Text(
// weatherData!.weatherStateName,
// style: TextStyle(
// fontSize: 32,
// fontWeight: FontWeight.bold,
// ),
// ),
// Spacer(
// flex: 5,
// ),
// ],
// ),
// ));
