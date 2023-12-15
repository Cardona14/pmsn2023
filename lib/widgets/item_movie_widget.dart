import 'package:flutter/material.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:pmsn2023/network/api_popular.dart';
import 'package:pmsn2023/screens/detail_movie_screen.dart';

Widget itemMovieWidget(PopularModel movie, context){
  return GestureDetector(
    onTap: () async {
      var api = ApiPopular();
      var idYT = await api.getMovieTrailer(movie.id!.toString());
      var cast = await api.getCast(movie.id!.toString());
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetailMovieScreen(
          movie: movie,
          id: idYT,
          cast: cast,
        )
      ));
    },
    child: Hero(
      tag: movie.id!,
      child: FadeInImage(
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 500),
        placeholder: const AssetImage('assets/loading.gif'),
        image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}')
      ),
    )
  );
}