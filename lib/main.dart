import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/styles_app.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/login_screen.dart';

void main() => runApp( MyApp());


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          home: const LoginScreen(),
          routes: getRoutes(),
          theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context)
          /*routes: {
            '/dash' : (BuildContext context) => LoginScreen()
          },*/
        );
      }
    );
  }
}


/*
Statefull Widget Contador de clicks

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  int? x;

  @override
  State<MyApp> createState() => _MyAppState();
  //El guieon bajo signitifica que el atributo es privado
}

class _MyAppState extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    contador = widget.x!;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body: Center(
          child: Text('Contador de Clicks $contador',
            style: TextStyle(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.mouse,
            color: Color.fromARGB(255, 255, 0, 0),
            ),
          onPressed: (){
            contador++;
            print(contador);
            setState(() {});
          }
        ),
      ),
    );
  }
}*/

/*
Stateless Widget

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  int contador = 0;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Contador de Clicks',
          style: TextStyle(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.mouse,
            color: Color.fromARGB(255, 255, 0, 0),
            ),
          onPressed: (){
            contador++;
            print(contador);
          }
        ),
      ),
    );
  }
}
*/