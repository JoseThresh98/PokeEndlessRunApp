import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import '../biome_run_game.dart';
import 'player_component.dart';

class ObstacleComponent extends SpriteComponent
    with HasGameReference<BiomeRunGame>, CollisionCallbacks {

  final String spritePath;

  ObstacleComponent({
    required Vector2 position,
    required Vector2 size,
    required this.spritePath,
  }) : super(
    position: position,
    size: size,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(spritePath);
    // Smaller hitbox than visual size to be more forgiving
    add(RectangleHitbox(
      size: Vector2(size.x * 0.6, size.y * 0.7),
      position: Vector2(size.x * 0.2, size.y * 0.3),
    ));
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