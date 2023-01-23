import 'dart:async';


import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Timer(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Home()));
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 145, 0),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Image.asset("imagens/home.png"),
        ),
      ),
    );
  }
}