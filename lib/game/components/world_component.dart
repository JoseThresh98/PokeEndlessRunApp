import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class WorldComponent extends Component {
  late RectangleComponent _background;
  late RectangleComponent _ground;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Sky background
    _background = RectangleComponent(
      position: Vector2.zero(),
      size: Vector2(800, 600),
      paint: Paint()..color = AppColors.background,
    );
    await add(_background);

    // Ground
    _ground = RectangleComponent(
      position: Vector2(0, 500),
      size: Vector2(800, 100),
      paint: Paint()..color = AppColors.forestGround,
    );
    await add(_ground);
  }
}