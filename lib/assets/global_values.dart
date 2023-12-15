import 'package:flutter/material.dart';

class GlobalValues {
  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(false);
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagDB = ValueNotifier<bool>(false);
  static ValueNotifier<bool> flagFavorite = ValueNotifier<bool>(false);
  static ValueNotifier<bool> flagWeather = ValueNotifier<bool>(false);
}