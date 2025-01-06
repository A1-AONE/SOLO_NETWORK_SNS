import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/home_view_model.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        final viewModel = ref.read(homeViewModel.notifier);
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: viewModel.onIndexChanged,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'MYPAGE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_fill),
              label: '염탐',
            ),
          ],
        );
      },
    );
  }
}
