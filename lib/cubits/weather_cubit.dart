import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../services/weather_service.dart';
import '../models/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());
  WeatherService weatherService;
  WeatherModel? weatherModel;

  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    weatherModel = await weatherService.getWeather(cityName: cityName);
    try {
      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}
