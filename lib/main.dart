import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/styles_app.dart';
import 'package:pmsn2023/provider/test_provider.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/card_onboard.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp());


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            home: onBoarding(), //const LoginScreen(),
            routes: getRoutes(),
            theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context)
            /*routes: {
              '/dash' : (BuildContext context) => LoginScreen()
            },*/
          ),
        );
      }
    );
  }
}


//Modificar ya las cartas y hacer reporte
class onBoarding extends StatelessWidget {
  onBoarding({super.key});

  final  data=[
    CardOnBoardData(
      title: "Bienvenido al TECNM en Celaya", 
      subtitle: "Ahora eres parte de la comunidad lince",
      image: AssetImage('assets/logo_lince.webp'), 
      backgroundColor: Colors.white, 
      titleColor: Color.fromARGB(255, 17, 117, 51), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/bg.json')
    ),
    CardOnBoardData(
      title: "Ingeniería en Sistemas Computacionales", 
      subtitle: "AEISC es la asociación estudiantil de tu carrera",
      image: AssetImage('assets/aeisc.png'), 
      backgroundColor: Color.fromARGB(255, 17, 117, 51), 
      titleColor:  Colors.white,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/circuito2.json')
    ),
    CardOnBoardData(
      title: "Campus 2", 
      subtitle: "En estos espacios disfrutarás de tu vida universitaria y aprenderás junto a tus compañeros",
      image: AssetImage('assets/campus2.jpg'), 
      backgroundColor: Colors.white, 
      titleColor: Color.fromARGB(255, 27, 57, 106), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/circuito1.json')
    ),
    CardOnBoardData(
      title: "Edificio de sistemas", 
      subtitle: "En este edificio recibirás clases, junto a los laboratorio de sistemas ubicado justo al frente de este",
      image: NetworkImage('https://lh5.googleusercontent.com/p/AF1QipPUEWq0TUzAnA_zZ1XSRQecB85U1FUSMNmBFuOo=w960-h720-k-no'), 
      backgroundColor: Color.fromARGB(255, 27, 57, 106), 
      titleColor:  Colors.white,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/circle.json')
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          itemBuilder:(int index){
            return CardOnBoard(data: data[index]);
          } ,
          onFinish: (){
            Navigator.pushNamed(context, '/dash');
          },
        )
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
  //El guion bajo signitifica que el atributo es privado
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