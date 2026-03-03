import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/creature_type.dart';
import '../biome_run_game.dart';

class PlayerComponent extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BiomeRunGame> {

  double get groundY => game.groundY - size.y + 10;

  CreatureType currentType = CreatureType.fire;
  double _velocityY = 0;
  bool _isOnGround = true;
  double _abilityCooldownTimer = 0;

  PlayerComponent() : super(size: Vector2(80, 80));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(100, groundY);
    await _loadSprite();
    // Smaller hitbox for fairer collisions
    add(RectangleHitbox(
      size: Vector2(size.x * 0.5, size.y * 0.7),
      position: Vector2(size.x * 0.25, size.y * 0.3),
    ));
  }

  Future<void> _loadSprite() async {
    sprite = await Sprite.load(_getSpritePath());
  }

  String _getSpritePath() {
    switch (currentType) {
      case CreatureType.fire:
        return 'creatures/emberon.png';
      case CreatureType.water:
        return 'creatures/aquafin.png';
      case CreatureType.psychic:
        return 'creatures/psywyn.png';
      case CreatureType.grass:
        return 'creatures/thornveil.png';
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_isOnGround) {
      _velocityY += AppConstants.gravity * dt;
      position.y += _velocityY * dt;
      if (position.y >= groundY) {
        position.y = groundY;
        _velocityY = 0;
        _isOnGround = true;
      }
    }
    if (_abilityCooldownTimer > 0) {
      _abilityCooldownTimer -= dt;
    }
  }

  void jump() {
    if (_isOnGround) {
      _velocityY = AppConstants.jumpForce;
      _isOnGround = false;
    }
  }

  void swapCreature(CreatureType type) {
    currentType = type;
    _loadSprite();
  }

  void useAbility() {
    if (_abilityCooldownTimer > 0) return;
    _abilityCooldownTimer = _getCooldown();
    switch (currentType) {
      case CreatureType.fire:
        position.x += 80;
        break;
      case CreatureType.water:
        _velocityY = AppConstants.jumpForce * 0.5;
        _isOnGround = false;
        break;
      case CreatureType.psychic:
        position.x += 120;
        break;
      case CreatureType.grass:
        _velocityY = AppConstants.jumpForce * 0.75;
        _isOnGround = false;
        break;
    }
  }

  double _getCooldown() {
    switch (currentType) {
      case CreatureType.fire:
        return AppConstants.fireDashCooldown;
      case CreatureType.water:
        return AppConstants.waterGlideCooldown;
      case CreatureType.psychic:
        return AppConstants.psychicTeleportCooldown;
      case CreatureType.grass:
        return AppConstants.grassVineCooldown;
    }
  }

  double get abilityCooldownPercent =>
      _abilityCooldownTimer / _getCooldown();
  bool get isAbilityReady => _abilityCooldownTimer <= 0;
}