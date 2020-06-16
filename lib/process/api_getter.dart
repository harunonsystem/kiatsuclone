import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kiatsuclone/model/weather_model.dart';
import 'package:weather/weather_library.dart';

final String apiKey = '85b471dd6643e05717257b12894250d1';

class ApiGetter {
  //Future<Secret> secret = SecretLoader(secretPath: 'api_key.json').load();
  Future<WeatherClass> getWeather() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=' +
        position.latitude.toString() +
        '&lon=' +
        position.longitude.toString() +
        '&APPID=$apiKey';
    final response = await http.get(url);
    return WeatherClass.fromJson(json.decode(response.body));
  }
}

class ForecastGetter {
  WeatherStation ws;
  String forecast = '';

  Future<List<Weather>> getForecast(Position position) async {
    return await ws.fiveDayForecast(position.latitude, position.longitude);
  }
  /*
  Future<List<Weather>> queryForecast() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    // Weather クラスに 5日分の天気情報格納
    List<Weather> f = await ws.fiveDayForecast(
        position.latitude.toDouble(), position.longitude.toDouble());
    forecast = f.toString();
    print(f);
  }

   */
}
