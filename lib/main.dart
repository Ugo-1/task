import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmgmt_app/screens/add_task.dart';
import 'package:taskmgmt_app/screens/get_started.dart';
import 'package:taskmgmt_app/screens/login.dart';
import 'package:taskmgmt_app/screens/register.dart';
import 'package:taskmgmt_app/screens/splash_screen.dart';
import 'package:taskmgmt_app/screens/todo.dart';
import 'package:taskmgmt_app/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  setupLocator();
  
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'A scheduled notification',
        importance: NotificationImportance.Max,
        locked: true,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
      ),
    ],
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        GetStarted.id: (context) => const GetStarted(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        TodoScreen.id: (context) => TodoScreen(),
        AddTaskScreen.id: (context) => const AddTaskScreen(),
      },
    );
  }
}

