import 'package:flutter/material.dart';
import 'package:pmsn2023/firebase/favorites_firebase.dart';

class PopularFirebaseScreen extends StatefulWidget {
  const PopularFirebaseScreen({super.key});

  @override
  State<PopularFirebaseScreen> createState() => _PopularFirebaseScreenState();
}

class _PopularFirebaseScreenState extends State<PopularFirebaseScreen> {

  FavoritesFirebase? _favoritesFirebase;

  @override
  void initState() {
    super.initState();
    _favoritesFirebase = FavoritesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _favoritesFirebase!.getAllFavorite(), 
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Image.network(snapshot.data!.docs[index].get('img')),
                    Text(snapshot.data!.docs[index].get('title')),
                  ],
                );
              },
            );
          }else{
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }else{
              return const Center(child: Text('Error'));
            }
          }
        }
      ),
    );
  }
}