import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_flutter/api/firebase_api.dart';
import 'package:firebase_notification_flutter/firebase_options.dart';
import 'package:firebase_notification_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await FirebaseMessaging.instance.subscribeToTopic("radioHotstarFlutter");

  AwesomeNotifications().initialize(null,
    [
      NotificationChannel(channelKey: "key1", channelName: "diginerds", channelDescription: "diginerds desc"
      ,defaultColor: const Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true
      )
    ]

  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        "/home_screen" : (context) => const HomePage(),
      },
    );
  }
}

