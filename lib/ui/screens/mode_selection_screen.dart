/// Mode Selection Screen - Choose game mode
/// شاشة اختيار نمط اللعبة
library;

import 'package:flutter/material.dart';
import 'package:b_brane/models/game_mode.dart';
import 'package:b_brane/utils/app_localizations.dart';

class ModeSelectionScreen extends StatelessWidget {
  final String language;
  final Function(GameMode) onModeSelected;

  const ModeSelectionScreen({
    super.key,
    required this.language,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app_name'.tr(language: language))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Game Mode',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildModeCard(
              context,
              mode: GameMode.wordToWord,
              icon: '📝',
              onTap: () => onModeSelected(GameMode.wordToWord),
            ),
            const SizedBox(height: 12),
            _buildModeCard(
              context,
              mode: GameMode.imageToImage,
              icon: '🖼️',
              onTap: () => onModeSelected(GameMode.imageToImage),
            ),
            const SizedBox(height: 12),
            _buildModeCard(
              context,
              mode: GameMode.emojiChain,
              icon: '😊',
              onTap: () => onModeSelected(GameMode.emojiChain),
            ),
            const SizedBox(height: 12),
            _buildModeCard(
              context,
              mode: GameMode.eventToEvent,
              icon: '📚',
              onTap: () => onModeSelected(GameMode.eventToEvent),
            ),
            const SizedBox(height: 12),
            _buildModeCard(
              context,
              mode: GameMode.linkChain,
              icon: '⛓️',
              onTap: () => onModeSelected(GameMode.linkChain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required GameMode mode,
    required String icon,
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
              Text(icon, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                mode.getName(language),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                mode.getDescription(language),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
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
