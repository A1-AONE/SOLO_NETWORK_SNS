import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:solo_network_sns/presentation/ui/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2500)).then((_) {
      context.go('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/animation/aone_splash.json'),
      ),
      nextScreen: LoginPage(),
      duration: 2500,
      backgroundColor: Colors.white,
      splashIconSize: 800,
    );
  }
}
