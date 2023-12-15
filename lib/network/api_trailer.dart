import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiTrailer {
  String? movieId;
  Uri? apiLink;
  ApiTrailer({this.movieId}) {
    apiLink = Uri.parse( "https://api.kinocheck.de/movies?tmdb_id=$movieId&language=en&categories=Trailer");
  }

  Future<String?> getYouTubeId() async {
    var response = await http.get(apiLink!);
    var jsonRes = "";
    if (response.statusCode == 200) {
      try {
        jsonRes = jsonDecode(response.body)["trailer"]["youtube_video_id"];
        return jsonRes.toString();
      } catch (e) {
        return "error jsonDecode";
      }
    } else {
      return "error status HTTP";
    }
  }
}
