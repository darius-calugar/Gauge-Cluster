import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/screens/playground_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black2,
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Tomorrow',
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: PlaygroundScreen(),
        ),
      ),
    );
  }
}
