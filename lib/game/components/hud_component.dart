import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/score_formatter.dart';
import '../biome_run_game.dart';

class HudComponent extends PositionComponent {
  final BiomeRunGame game;

  late TextComponent _scoreText;
  late TextComponent _coinsText;
  late TextComponent _gemsText;

  HudComponent({required this.game});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(16, 16),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: AppColors.scoreColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    _coinsText = TextComponent(
      text: '🪙 0',
      position: Vector2(16, 40),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: AppColors.coinColor,
          fontSize: 14,
        ),
      ),
    );

    _gemsText = TextComponent(
      text: '💎 0',
      position: Vector2(16, 60),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: AppColors.gemColor,
          fontSize: 14,
        ),
      ),
    );

    await addAll([_scoreText, _coinsText, _gemsText]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _scoreText.text = 'Score: ${ScoreFormatter.format(game.currentScore)}';
    _coinsText.text = '🪙 ${game.sessionCoins}';
    _gemsText.text = '💎 ${game.sessionGems}';
  }
}