import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/repositories/score_repository.dart';
import '../../core/utils/score_formatter.dart';

class MainMenuScreen extends StatelessWidget {
  final VoidCallback onPlay;
  final ScoreRepository scoreRepository;

  const MainMenuScreen({
    super.key,
    required this.onPlay,
    required this.scoreRepository,
  });

  @override
  Widget build(BuildContext context) {
    final score = scoreRepository.getScore();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'POKE',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
            const Text(
              'BIOME RUN',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Best: ${ScoreFormatter.format(score.highScore)}',
              style: const TextStyle(
                color: AppColors.scoreColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🪙 ${score.totalCoins}',
                  style: const TextStyle(
                    color: AppColors.coinColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  '💎 ${score.totalGems}',
                  style: const TextStyle(
                    color: AppColors.gemColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: onPlay,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 64, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'PLAY',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap to jump • Use abilities to survive',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}