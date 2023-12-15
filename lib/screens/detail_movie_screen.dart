import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  DetailMovieScreen({super.key, this.movie, this.id, this.cast});
  PopularModel? movie;
  String? id;
  Map<int, dynamic>? cast;

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  YoutubePlayerController? controller;
  bool? isFav = false;
  AgendaDB? agendaDB = AgendaDB();
  
  @override
  void initState() {
    super.initState();
    if (widget.id != "") {
      controller = YoutubePlayerController(initialVideoId: widget.id!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false
        ),
      );
    }
    getFavMovie();
  }

  Future getFavMovie() async {
    var movie = await agendaDB!.GETMOVIE(widget.movie!.id!);
    if (movie != null) {
      setState(() {
        isFav = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: widget.id == ""
              ? const Text("Video no disponible")
              : Stack(
                  children: [
                    YoutubePlayer(
                      controller: controller!,
                      liveUIColor: Colors.red,
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: ValueListenableBuilder(
                        valueListenable: GlobalValues.flagFavorite,
                        builder: (context, value, _) {
                          return IconButton(
                            onPressed: () async {
                              if (isFav == false) {
                                agendaDB!.INSERT("tblMovies", {
                                  "backdrop_path":widget.movie!.backdropPath,
                                  "id": widget.movie!.id,
                                  "original_language":widget.movie!.originalLanguage,
                                  "original_title":widget.movie!.originalTitle,
                                  "overview": widget.movie!.overview,
                                  "popularity": widget.movie!.popularity,
                                  "poster_path": widget.movie!.posterPath,
                                  "release_date": widget.movie!.releaseDate,
                                  "title": widget.movie!.title,
                                  "vote_average":widget.movie!.voteAverage,
                                  "vote_count": widget.movie!.voteCount,
                                  "trailerVideo": widget.id
                                });
                                isFav = true;
                              } else {
                                agendaDB!.DELETE("movies", "id", widget.movie!.id!, null);
                                isFav = false;
                              }
                              GlobalValues.flagFavorite.value = !GlobalValues.flagFavorite.value;
                            },
                            icon: isFav == true
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                          );
                        }
                      )
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 154, 151, 151),
                        )
                      )
                    )
                  ],
                ),
          ),
          Expanded(
            child: Hero(
              tag: widget.movie!.id!,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.cover,
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.movie!.posterPath!}'))),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        widget.movie!.title!,
                        style: GoogleFonts.bungee(fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: Center(
                        child: Text("Clasificacion: ${widget.movie!.voteAverage!.toString()}",
                          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    RatingBar.builder(
                      initialRating: widget.movie!.voteAverage!,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 10,
                      ignoreGestures: true,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: Center(
                        child: Text("Elenco",
                          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.cast!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    widget.cast![index]["photo"] != ""
                                      ? ClipOval(
                                          child: Image.network('https://image.tmdb.org/t/p/w500/${widget.cast![index]["photo"]}',width: 50),
                                        )
                                      : Image.asset("assets/naranja.png"),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                        width: 150,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.cast![index]["name"],
                                              style: GoogleFonts.exo(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              widget.cast![index] ["movieName"],
                                              style: const TextStyle(fontSize: 10)
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Text(
                              widget.movie!.overview!,
                              style: GoogleFonts.roboto(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}