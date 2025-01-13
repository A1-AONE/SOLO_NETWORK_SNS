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
  bool _isAnimationLoaded = false;

  void _startNavigationTimer() {
    Future.delayed(const Duration(milliseconds: 3000)).then((_) {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/aone_splash.json',
                onLoaded: (state) {
              if (!_isAnimationLoaded) {
                _isAnimationLoaded = true;
                _startNavigationTimer();
              }
            }),
          ],
        ),
      ),
    );
  }
}
