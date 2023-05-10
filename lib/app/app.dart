import 'package:flutter/material.dart';
import 'package:test_yaho/core/config/colors.dart';
import 'package:test_yaho/views/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: const AppBarTheme(color: AppColors.orange),
        colorScheme: ColorScheme.fromSwatch(
            accentColor: AppColors.orange, backgroundColor: AppColors.orange),
      ),
      home: const HomeScreen(),
    );
  }
}
