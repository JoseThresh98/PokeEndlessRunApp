import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'package:flame/game.dart';
import '../biome_run_game.dart';

class WorldComponent extends Component with HasGameReference<BiomeRunGame> {
  late RectangleComponent _background;
  late RectangleComponent _ground;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final size = game.size; // ← dynamic screen size

    _background = RectangleComponent(
      position: Vector2.zero(),
      size: size,
      paint: Paint()..color = AppColors.background,
    );
    await add(_background);

    _ground = RectangleComponent(
      position: Vector2(0, size.y * 0.85),
      size: Vector2(size.x, size.y * 0.15),
      paint: Paint()..color = AppColors.forestGround,
    );
    await add(_ground);
  }

}