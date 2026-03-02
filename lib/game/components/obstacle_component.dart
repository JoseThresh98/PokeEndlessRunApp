import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../biome_run_game.dart';
import 'player_component.dart';

class ObstacleComponent extends RectangleComponent
    with HasGameReference<BiomeRunGame>, CollisionCallbacks {

  ObstacleComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    paint: Paint()..color = AppColors.accent,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
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
      game.triggerGameOver();
    }
  }
}