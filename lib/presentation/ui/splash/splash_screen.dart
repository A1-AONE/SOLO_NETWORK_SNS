import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2600)).then((_) {
      context.go('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedSplashScreen(
    //   splash: Center(
    //     child: Lottie.asset('assets/animation/aone_splash.json'),
    //   ),
    //   nextScreen: LoginPage(),
    //   duration: 2500,
    //   backgroundColor: Colors.white,
    //   splashIconSize: 800,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/aone_splash.json'),
          ],
        ),
      ),
    );
  }
}
