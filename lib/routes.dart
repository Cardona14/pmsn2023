import 'package:flutter/material.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash': (BuildContext context) => DashboardScreen()
  };
}