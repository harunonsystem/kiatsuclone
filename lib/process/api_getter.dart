import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kiatsuclone/model/weather_model.dart';
import 'package:kiatsuclone/process/secret_loader.dart';

class ApiGetter {
  Future<Secret> secret = SecretLoader(secretPath: 'api_key.json').load();
  final String key = '85b471dd6643e05717257b12894250d1';
  Future<WeatherClass> getWeather() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=' +
        position.latitude.toString() +
        '&lon=' +
        position.longitude.toString() +
        '&APPID=$key';
    final response = await http.get(url);
    print(secret);
    print(url);
    return WeatherClass.fromJson(json.decode(response.body));
  }
}
