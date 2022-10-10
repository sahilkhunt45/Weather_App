import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/weather.dart';

class WeatherAPIHelper {
  WeatherAPIHelper._();

  static final WeatherAPIHelper apiHelper = WeatherAPIHelper._();

  Future<Weather?> fechWeatherData({required String city}) async {
    const String BASE_URL = "https://api.openweathermap.org/data/2.5";
    final String ENDPOINT =
        "/weather?q=$city,IN&appid=dc4981ca50c5ad58a3304ed3e5b76dd2";
    Global.city = city;
    http.Response res = await http.get(Uri.parse(BASE_URL + ENDPOINT));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeData = jsonDecode(res.body);
      Weather weather = Weather.fromJson(json: decodeData);
      return weather;
    }
    return null;
  }
}

class Global {
  static String? city;
}
