/// Difficulty Selection Screen - Choose difficulty level
/// شاشة اختيار مستوى الصعوبة
library;

import 'package:flutter/material.dart';
import 'package:b_brane/models/difficulty.dart';
import 'package:b_brane/utils/app_localizations.dart';

class DifficultySelectionScreen extends StatelessWidget {
  final String language;
  final Function(Difficulty) onDifficultySelected;

  const DifficultySelectionScreen({
    super.key,
    required this.language,
    required this.onDifficultySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Difficulty')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'difficulty_easy'.tr(language: language),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildDifficultyCard(
              context,
              difficulty: Difficulty.easy,
              emoji: '🟢',
              multiplier: '1.0x',
              timer: '15s',
              options: '2 wrong',
              onTap: () => onDifficultySelected(Difficulty.easy),
            ),
            const SizedBox(height: 12),
            _buildDifficultyCard(
              context,
              difficulty: Difficulty.medium,
              emoji: '🟡',
              multiplier: '1.5x',
              timer: '12s',
              options: '4 wrong',
              onTap: () => onDifficultySelected(Difficulty.medium),
            ),
            const SizedBox(height: 12),
            _buildDifficultyCard(
              context,
              difficulty: Difficulty.expert,
              emoji: '🔴',
              multiplier: '2.0x',
              timer: '10s',
              options: '5 wrong',
              onTap: () => onDifficultySelected(Difficulty.expert),
            ),
            const SizedBox(height: 12),
            _buildDifficultyCard(
              context,
              difficulty: Difficulty.legendary,
              emoji: '⚫',
              multiplier: '3.0x',
              timer: '8s',
              options: '6 wrong',
              onTap: () => onDifficultySelected(Difficulty.legendary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyCard(
    BuildContext context, {
    required Difficulty difficulty,
    required String emoji,
    required String multiplier,
    required String timer,
    required String options,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 36)),
                  Text(
                    difficulty.getArabicName(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Score Multiplier',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        multiplier,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Timer',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        timer,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        options,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onTap,
                child: Text('Select'.tr(language: language)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
