import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../data/repositories/score_repository.dart';
import 'components/world_component.dart';
import 'components/player_component.dart';
import 'components/hud_component.dart';
import 'components/spawner_component.dart';

class BiomeRunGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {

  late PlayerComponent player;
  late WorldComponent gameWorld;
  late HudComponent hud;

  final ScoreRepository scoreRepository;
  final VoidCallback onGameOver;

  int currentScore = 0;
  int sessionCoins = 0;
  int sessionGems = 0;
  bool isGameOver = false;
  double groundY = 0;

  double _gameSpeed = AppConstants.gameSpeed;
  double get gameSpeed => _gameSpeed;

  BiomeRunGame({
    required this.scoreRepository,
    required this.onGameOver,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    groundY = size.y * 0.85;
    gameWorld = WorldComponent();
    await add(gameWorld);
    player = PlayerComponent();
    await add(player);
    hud = HudComponent(game: this);
    await add(hud);
    await add(SpawnerComponent());
    add(ScreenHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;
    currentScore += (dt * AppConstants.scorePerMeter * _gameSpeed / 100).round();
    _gameSpeed += AppConstants.speedIncrement * dt;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isGameOver) {
      player.jump();
    }
  }

  void collectCoin() {
    sessionCoins += AppConstants.coinValue;
    currentScore += AppConstants.coinValue;
  }

  void collectGem() {
    sessionGems += AppConstants.gemValue;
    currentScore += AppConstants.gemValue;
  }

  Future<void> triggerGameOver() async {
    isGameOver = true;
    pauseEngine();
    await scoreRepository.updateHighScore(currentScore);
    await scoreRepository.addCoins(sessionCoins);
    await scoreRepository.addGems(sessionGems);
    onGameOver(); // ← triggers Navigator.push in Flutter
  }
}