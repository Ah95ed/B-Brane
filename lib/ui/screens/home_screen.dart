/// Home Screen - Main Entry Point
/// الصفحة الرئيسية - نقطة الدخول الرئيسية
library;

import 'package:flutter/material.dart';
import 'package:b_brane/models/game_mode.dart';
import 'package:b_brane/models/difficulty.dart';
import 'package:b_brane/ui/screens/game_screen.dart';
import 'package:b_brane/utils/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String language = 'en';

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.strings[language] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(strings['app_name'] ?? 'الرابط العجيب'),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {
              setState(() {
                language = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'ar', child: Text('العربية')),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                strings['app_name'] ?? 'الرابط العجيب',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                strings['app_tagline'] ?? 'أوجد الاتصال',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => _showGameModes(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  strings['play'] ?? 'العب',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  strings['leaderboard'] ?? 'لوحة الصدارة',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  strings['profile'] ?? 'الملف الشخصي',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGameModes(BuildContext context) {
    final modes = GameMode.values;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Game Mode',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              ...modes.map((mode) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDifficulties(context, mode);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(mode.getName(language)),
                  ),
                );
              }),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDifficulties(BuildContext context, GameMode mode) {
    final difficulties = Difficulty.values;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Difficulty',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              ...difficulties.map((difficulty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _navigateToGame(context, mode, difficulty);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(difficulty.getName(language)),
                  ),
                );
              }),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToGame(
    BuildContext context,
    GameMode mode,
    Difficulty difficulty,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen(language: language)),
    );
  }
}
