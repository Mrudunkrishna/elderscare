import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:elderscareapp/admin/admin1.dart';
import 'package:elderscareapp/bottomtab/bottomtab.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:elderscareapp/registr/loginregstr.dart';
import 'package:elderscareapp/signup/googlesignup.dart';
import 'package:elderscareapp/signup/signinsmll.dart';
import 'package:elderscareapp/splashscreen.dart';
import 'package:elderscareapp/firebase_options.dart';
import 'package:elderscareapp/welcome1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'home/notification.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  // tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(channelKey: 'basic_channel',
          channelName: 'Basic_notifications',
          channelDescription: 'Notification_channel',
      ),
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => splash(),
        '/login': (context) => signinsmll(),
        '/home': (context) => BottomTabBar(),
        '/welcome': (context) => welcome(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  void _navigateBasedOnLoginStatus() async {
    bool isLoggedIn = await SharedPrefHelper.getLoginStatus();
    await Future.delayed(Duration(seconds: 2)); // Adding a delay for the splash screen
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
