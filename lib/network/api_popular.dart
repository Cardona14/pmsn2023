import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmsn2023/models/popular_model.dart';

class ApiPopular {

  Future<List<PopularModel>?> getAllPopular() async {
    Uri link = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=4056478de8d3d1d7d070e876eac3016f&language=en-MX&page=1)");
    var response = await http.get(link);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)["results"] as List;
      return jsonResult.map((popular) => PopularModel.fromMap(popular)).toList();
    } else {
      return null;
    }
  }

  Future<String?> getMovieTrailer(String movieId) async {
    Uri link = Uri.parse("https://api.themoviedb.org/3/movie/$movieId/videos?api_key=4056478de8d3d1d7d070e876eac3016f&language=en");
    var response = await http.get(link);

    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)["results"] as List;
      var idVideo = "";
      for (var element in jsonResult) {
        if (!element["name"].toString().contains("Teaser")) {
          if (element["name"].toString() == "Official Trailer") {
            idVideo = element["key"];
            break;
          } else if (element["name"].toString().contains("Trailer")) {
            idVideo = element["key"];
          }
        }
      }
      return idVideo;
    } else {
      return null;
    }
  }

  Future<Map<int, dynamic>?> getCast(String movieId) async {
    Uri link = Uri.parse("https://api.themoviedb.org/3/movie/$movieId/credits?api_key=4056478de8d3d1d7d070e876eac3016f&language=en");
    Map<int, dynamic> castList = {};
    var response = await http.get(link);

    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)["cast"] as List;
      var i = 0;
      for (var element in jsonResult) {
        if (element["known_for_department"] == "Acting") {
          castList[i] = {
            "name": element["name"],
            "movieName": element["character"] ?? "",
            "photo": element["profile_path"] ?? ""
          };
          i++;
        }
      }
      return castList;
    } else {
      return null;
    }
  }
}