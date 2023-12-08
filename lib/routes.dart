import 'package:flutter/material.dart';
import 'package:pmsn2023/screens/add_task.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/screens/fruitapp_screen.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/maps_screen.dart';
import 'package:pmsn2023/screens/popular_screen.dart';
import 'package:pmsn2023/screens/provider_screen.dart';
import 'package:pmsn2023/screens/task_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => const PopularScreen(),
    '/store' : (BuildContext context) => const FruitAppScreen(),
    '/detail' : (BuildContext context) => const DetailMovieScreen(),
    '/provider' : (BuildContext context) => const ProviderScreen(),
    '/maps' : (BuildContext context) => const MapsScreen(),
  };
}