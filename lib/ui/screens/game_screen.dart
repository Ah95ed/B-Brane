/// Game Screen - Main gameplay screen
/// شاشة اللعبة الرئيسية
library;

import 'package:flutter/material.dart';
import 'package:b_brane/utils/app_localizations.dart';

class GameScreen extends StatefulWidget {
  final String language;

  const GameScreen({super.key, required this.language});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _remainingTime;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = 15;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_remainingTime > 0 && !_answered && mounted) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('find_link'.tr(language: widget.language)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                '$_remainingTime s',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(value: 0.5, minHeight: 8),
            const SizedBox(height: 16),
            Text('1/10', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 48)),
                          const SizedBox(height: 8),
                          Text(
                            'نار',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('?', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text('💨', style: TextStyle(fontSize: 48)),
                          const SizedBox(height: 8),
                          Text(
                            'دخان',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'select_answer'.tr(language: widget.language),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ..._buildAnswerOptions(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnswerOptions(BuildContext context) {
    final options = ['حريق', 'دخان', 'نار', 'شرارة'];
    return options
        .asMap()
        .entries
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _answered
                    ? null
                    : () {
                        setState(() {
                          _answered = true;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _answered ? Colors.grey : null,
                ),
                child: Text(entry.value),
              ),
            ),
          ),
        )
        .toList();
  }
}
