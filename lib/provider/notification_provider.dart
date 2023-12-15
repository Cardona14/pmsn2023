import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings = InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({var id = 0, required String title, required String body, var payload}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Task Agenda',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notification = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, notification);
  }
}
