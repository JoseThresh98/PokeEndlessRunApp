import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../biome_run_game.dart';
import '../biomes/biome_type.dart';

class WorldComponent extends Component with HasGameReference<BiomeRunGame> {
  BiomeType currentBiome = BiomeType.forest;
  BiomeType _nextBiome = BiomeType.volcano;

  late SpriteComponent _background;
  late SpriteComponent _groundLeft;
  late SpriteComponent _groundRight;

  double _groundScrollX = 0;
  bool _isTransitioning = false;
  double _transitionAlpha = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadBiome(currentBiome);
  }

  Future<void> _loadBiome(BiomeType biome) async {
    // Remove old components
    removeAll(children);

    final size = game.size;

    // Background
    final bgSprite = await Sprite.load(biome.backgroundPath);
    _background = SpriteComponent(
      sprite: bgSprite,
      position: Vector2.zero(),
      size: Vector2(size.x, size.y),
    );
    await add(_background);

    // Ground — two tiles side by side for seamless scrolling
    final groundSprite = await Sprite.load(biome.groundPath);
    final groundHeight = size.y * 0.18;
    final groundY = size.y * 0.82;

    _groundLeft = SpriteComponent(
      sprite: groundSprite,
      position: Vector2(0, groundY),
      size: Vector2(size.x, groundHeight),
    );

    _groundRight = SpriteComponent(
      sprite: groundSprite,
      position: Vector2(size.x, groundY),
      size: Vector2(size.x, groundHeight),
    );

    await add(_groundLeft);
    await add(_groundRight);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.isGameOver) return;

    // Scroll ground
    _groundScrollX -= game.gameSpeed * 0.5 * dt;

    if (_groundScrollX <= -game.size.x) {
      _groundScrollX = 0;
    }

    _groundLeft.position.x = _groundScrollX;
    _groundRight.position.x = _groundScrollX + game.size.x;

    // Check biome transition
    _checkBiomeTransition();
  }

  void _checkBiomeTransition() {
    final score = game.currentScore;
    BiomeType newBiome = BiomeType.forest;

    if (score >= BiomeType.crystal.scoreThreshold) {
      newBiome = BiomeType.crystal;
    } else if (score >= BiomeType.ocean.scoreThreshold) {
      newBiome = BiomeType.ocean;
    } else if (score >= BiomeType.volcano.scoreThreshold) {
      newBiome = BiomeType.volcano;
    }

    if (newBiome != currentBiome && !_isTransitioning) {
      _isTransitioning = true;
      currentBiome = newBiome;
      _loadBiome(newBiome).then((_) {
        _isTransitioning = false;
        // Notify spawner of biome change
        game.onBiomeChanged(newBiome);
      });
    }
  }
}