import 'package:flutter/material.dart';
import 'package:pmsn2023/screens/add_task.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/screens/popular_screen.dart';
import 'package:pmsn2023/screens/provider_screen.dart';
import 'package:pmsn2023/screens/task_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/dash': (BuildContext context) => DashboardScreen(),
    '/task': (BuildContext context) => TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => PopularScreen(),
    '/detail' : (BuildContext context) => DetailMovieScreen(),
    '/provider' : (BuildContext context) => ProviderScreen(),
    
  };
}