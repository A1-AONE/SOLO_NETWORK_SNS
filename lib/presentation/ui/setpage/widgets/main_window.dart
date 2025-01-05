import 'package:flutter/material.dart';

class MainWindow extends StatelessWidget {
  const MainWindow({super.key, this.setPageState});

  final setPageState;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: setPageState.pages[setPageState.currentPage]);
  }
}