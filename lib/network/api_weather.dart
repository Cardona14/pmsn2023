import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiWeather {
  String? lat;
  String? lon;
  Uri? link1;
  Uri? link2;
  ApiWeather({this.lat, this.lon}) {
    link1 = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&lang=es&appid=ba6945fa4f0688af58c4aa72b5de7f6f");
    link2 = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=es&units=metric&appid=ba6945fa4f0688af58c4aa72b5de7f6f");
  }
  Future<Map?> getWeather() async {
    var response = await http.get(link1!);
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      return jsonRes;
    } else {
      return null;
    }
  }

  Future<Map?> getCurrentWeather() async {
    var response = await http.get(link2!);
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      return jsonRes;
    } else {
      return null;
    }
  }
}