import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_brane/logic/providers/game_provider.dart';
import 'package:b_brane/ui/theme/app_theme.dart';
import 'package:b_brane/ui/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => GameProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الرابط العجيب - Weird Link',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
