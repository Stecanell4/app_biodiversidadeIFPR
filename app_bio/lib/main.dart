import 'package:bio_if/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
  ));
}
