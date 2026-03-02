import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../biome_run_game.dart';
import 'player_component.dart';

enum CollectibleType { coin, gem }

class CoinComponent extends CircleComponent
    with HasGameReference<BiomeRunGame>, CollisionCallbacks {

  final CollectibleType collectibleType;

  CoinComponent({
    required Vector2 position,
    this.collectibleType = CollectibleType.coin,
  }) : super(
    radius: 12,
    position: position,
    paint: Paint()
      ..color = collectibleType == CollectibleType.coin
          ? AppColors.coinColor
          : AppColors.gemColor,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= game.gameSpeed * dt;
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayerComponent) {
      if (collectibleType == CollectibleType.coin) {
        game.collectCoin();
      } else {
        game.collectGem();
      }
      removeFromParent();
    }
  }
}