import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/preferences_helper.dart';
import 'package:pmsn2023/assets/styles_app.dart';
import 'package:pmsn2023/provider/test_provider.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/card_onboard.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalValues.flagTheme.value = await PreferencesHelper.getTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PreferencesHelper.getLoggedInStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final isLoggedIn = snapshot.data ?? false;
          
          return ValueListenableBuilder<bool>(
            valueListenable: GlobalValues.flagTheme,
            builder: (context, value, _) {
              return ChangeNotifierProvider(
                create: (context) => TestProvider(),
                child: MaterialApp(
                  home: isLoggedIn ? const DashboardScreen() : onBoarding(),
                  routes: getRoutes(),
                  theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context),
                ),
              );
            },
          );
        }
      },
    );
  }
}



class onBoarding extends StatelessWidget {
  onBoarding({super.key});

  final  data=[
    CardOnBoardData(
      title: "Bienvenido al TECNM en Celaya", 
      subtitle: "Ahora eres parte de la comunidad lince",
      image: const AssetImage('assets/logo_lince.webp'), 
      backgroundColor: Colors.white, 
      titleColor: const Color.fromARGB(255, 17, 117, 51), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/animations/bg.json')
    ),
    CardOnBoardData(
      title: "Ingeniería en Sistemas Computacionales", 
      subtitle: "AEISC es la asociación estudiantil de tu carrera",
      image: const AssetImage('assets/aeisc.png'), 
      backgroundColor: const Color.fromARGB(255, 17, 117, 51), 
      titleColor:  Colors.white,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/animations/circuito2.json')
    ),
    CardOnBoardData(
      title: "Campus 2", 
      subtitle: "En estos espacios disfrutarás de tu vida universitaria y aprenderás junto a tus compañeros",
      image: const AssetImage('assets/campus2.jpg'), 
      backgroundColor: Colors.white, 
      titleColor: const Color.fromARGB(255, 27, 57, 106), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/animations/circuito1.json')
    ),
    CardOnBoardData(
      title: "Edificio de sistemas", 
      subtitle: "En este edificio recibirás clases, junto a los laboratorio de sistemas ubicado justo al frente de este",
      image: const NetworkImage('https://lh5.googleusercontent.com/p/AF1QipPUEWq0TUzAnA_zZ1XSRQecB85U1FUSMNmBFuOo=w960-h720-k-no'), 
      backgroundColor: const Color.fromARGB(255, 27, 57, 106), 
      titleColor:  Colors.white,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/animations/circle.json')
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
          },
          onFinish: (){
            Navigator.pushNamed(context, '/login');
          },
        )
    );
  }
}