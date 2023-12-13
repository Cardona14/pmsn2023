import 'package:flutter/material.dart';
import 'package:pmsn2023/widgets/counter.dart';
import 'package:pmsn2023/widgets/image_carousel_widget.dart';

class FruitAppScreen extends StatefulWidget {
  const FruitAppScreen({super.key});

  @override
  State<FruitAppScreen> createState() => _FruitAppScreenState();
}

class _FruitAppScreenState extends State<FruitAppScreen> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {_isFavorited = !_isFavorited;});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Row(
            children: <Widget>[
              const SizedBox(width: 5.0),
              IconButton(
                color: const Color.fromARGB(255, 17, 117, 51),
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushNamed(context, '/dash'),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 17, 117, 51),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 20.0),
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const CarouselWithIndicatorDemo(),
                const SizedBox(height: 50.0),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 17, 117, 51),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )
                  ),
                  height: 600,
                  width: 500,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          const Text(
                            'Flipper Zero',
                            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(height: 10.0),
                          const Text('\$170 cada uno'),
                          const SizedBox(height: 20.0),
                          const CounterDesign(),
                          const SizedBox(height: 30.0),
                          const Text(
                            'Descripción del Producto',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            'Flipper Zero es una multiherramienta portátil para pentesters y geeks en un cuerpo similar a un juguete.'
                            'Le encanta piratear material digital, como protocolos de radio, NFC, infrarrojo, hardware y más.'
                            'Es totalmente de código abierto y personalizable, por lo que puedes ampliarlo como quieras.',
                            style: TextStyle(letterSpacing: 2.0, fontSize: 15.0),
                          ),
                          const SizedBox(height: 30.0),
                          Row(
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                height: 70.0,
                                minWidth: 300,
                                child: ElevatedButton(
                                  onPressed: _toggleFavorite,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 17, 117, 51),
                                    elevation: 0,
                                  ),
                                  child: Icon(
                                    _isFavorited ? Icons.favorite_border : Icons.favorite,
                                    color: Colors.white,
                                  ),
                                )
                              ),
                              const SizedBox(width: 20.0),
                              ButtonTheme(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                height: 70.0,
                                minWidth: 300.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Add to cart',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}