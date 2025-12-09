/// Results Screen - Show game results
/// شاشة النتائج
library;

import 'package:flutter/material.dart';
import 'package:b_brane/utils/app_localizations.dart';

class ResultsScreen extends StatelessWidget {
  final String language;
  final int correctAnswers;
  final int totalQuestions;
  final int score;
  final int timePlayed;
  final VoidCallback onPlayAgain;
  final VoidCallback onBackHome;

  const ResultsScreen({
    super.key,
    required this.language,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.score,
    required this.timePlayed,
    required this.onPlayAgain,
    required this.onBackHome,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = (correctAnswers / totalQuestions * 100).toStringAsFixed(1);
    final minutes = timePlayed ~/ 60;
    final seconds = timePlayed % 60;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Text(
                'game_over'.tr(language: language),
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      /// Score
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'final_score'.tr(language: language),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$score',
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Stats Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildStatCard(
                            context,
                            label: 'correct_answers'.tr(language: language),
                            value: '$correctAnswers/$totalQuestions',
                            icon: '✓',
                            color: Colors.green,
                          ),
                          _buildStatCard(
                            context,
                            label: 'accuracy'.tr(language: language),
                            value: '$accuracy%',
                            icon: '🎯',
                            color: Colors.blue,
                          ),
                          _buildStatCard(
                            context,
                            label: 'time_played'.tr(language: language),
                            value:
                                '$minutes:${seconds.toString().padLeft(2, '0')}',
                            icon: '⏱️',
                            color: Colors.orange,
                          ),
                          _buildStatCard(
                            context,
                            label: 'level'.tr(language: language),
                            value: '5',
                            icon: '⭐',
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPlayAgain,
                  child: Text('play_again'.tr(language: language)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onBackHome,
                  child: Text('back_to_home'.tr(language: language)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required String icon,
    required Color color,
  }) {
    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
