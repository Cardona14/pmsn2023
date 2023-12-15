import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:pmsn2023/widgets/item_movie_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  AgendaDB agendaDB = AgendaDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas Favoritas"),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagFavorite,
        builder: (context, value, _) {
          return FutureBuilder(
            future: agendaDB.GETALLMOVIES(),
            builder: (context, AsyncSnapshot<List<PopularModel>> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return itemMovieWidget(snapshot.data![index], context);
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Algo salio mal '));
              } else {
                return const CircularProgressIndicator();
              }
            }
          );
        }
      )
    );
  }
}