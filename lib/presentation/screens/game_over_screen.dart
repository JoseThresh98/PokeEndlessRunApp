import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/score_formatter.dart';
import '../../data/repositories/score_repository.dart';
import '../../game/biome_run_game.dart';

class GameOverScreen extends StatelessWidget {
  final BiomeRunGame game;
  final ScoreRepository scoreRepository;
  final VoidCallback onRestart;
  final VoidCallback onMenu;

  const GameOverScreen({
    super.key,
    required this.game,
    required this.scoreRepository,
    required this.onRestart,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final score = scoreRepository.getScore();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Score: ${ScoreFormatter.format(game.currentScore)}',
              style: const TextStyle(
                color: AppColors.scoreColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Best: ${ScoreFormatter.format(score.highScore)}',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🪙 ${game.sessionCoins}',
                  style: const TextStyle(
                    color: AppColors.coinColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  '💎 ${game.sessionGems}',
                  style: const TextStyle(
                    color: AppColors.gemColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'PLAY AGAIN',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false),
              child: const Text(
                'MAIN MENU',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}