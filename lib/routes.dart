import 'package:flutter/material.dart';
import 'package:pmsn2023/screens/add_career_screen.dart';
import 'package:pmsn2023/screens/add_task_screen.dart';
import 'package:pmsn2023/screens/add_techaer_screen.dart';
import 'package:pmsn2023/screens/calendar_screen.dart';
import 'package:pmsn2023/screens/career_screen.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/screens/fruitapp_screen.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/maps_screen.dart';
import 'package:pmsn2023/screens/popular_screen.dart';
import 'package:pmsn2023/screens/provider_screen.dart';
import 'package:pmsn2023/screens/task_screen.dart';
import 'package:pmsn2023/screens/teacher_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/tasks': (BuildContext context) => const TaskScreen(),
    '/addTask': (BuildContext context) => AddTaskScreen(),
    '/careers': (BuildContext context) => const CareerScreen(),
    '/addCareer': (BuildContext context) => AddCareerScreen(),
    '/teachers': (BuildContext context) => const TeacherScreen(),
    '/addTeacher': (BuildContext context) => AddTeacherScreen(),
    '/calendar': (BuildContext context) => const CalendarScreen(),
    '/popular' : (BuildContext context) => const PopularScreen(),
    '/store' : (BuildContext context) => const FruitAppScreen(),
    '/detail' : (BuildContext context) => const DetailMovieScreen(),
    '/provider' : (BuildContext context) => const ProviderScreen(),
    '/maps' : (BuildContext context) => const MapsScreen(),
  };
}