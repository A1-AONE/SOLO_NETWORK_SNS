import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/bottom_navigation.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/home_indexed_stack.dart';

class HomeTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeIndexedStack(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}