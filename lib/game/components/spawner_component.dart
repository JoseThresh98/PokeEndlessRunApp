import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../../core/constants/app_constants.dart';
import '../biome_run_game.dart';
import 'obstacle_component.dart';
import 'coin_component.dart';

class SpawnerComponent extends Component
    with HasGameReference<BiomeRunGame> {

  final Random _random = Random();
  double _obstacleTimer = 0;
  double _coinTimer = 0;

  double get _obstacleInterval =>
      2.5 - (game.gameSpeed - AppConstants.gameSpeed) / 500;

  @override
  void update(double dt) {
    super.update(dt);
    if (game.isGameOver) return;

    _obstacleTimer += dt;
    _coinTimer += dt;

    if (_obstacleTimer >= _obstacleInterval.clamp(1.0, 2.5)) {
      _spawnObstacle();
      _obstacleTimer = 0;
    }

    if (_coinTimer >= 1.5) {
      _spawnCollectible();
      _coinTimer = 0;
    }
  }

  void _spawnObstacle() {
    final height = _random.nextDouble() * 40 + 40;
    game.add(ObstacleComponent(
      position: Vector2(850, 500 - height),
      size: Vector2(30, height),
    ));
  }

  void _spawnCollectible() {
    final isGem = _random.nextDouble() < 0.15;
    final yPos = _random.nextDouble() * 150 + 300;
    game.add(CoinComponent(
      position: Vector2(850, yPos),
      collectibleType:
      isGem ? CollectibleType.gem : CollectibleType.coin,
    ));
  }
}