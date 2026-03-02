import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/creature_type.dart';
import '../../core/theme/app_colors.dart';

class PlayerComponent extends RectangleComponent with CollisionCallbacks {
  static const double groundY = 436.0;

  double _velocityY = 0;
  bool _isOnGround = true;
  bool _isAbilityActive = false;
  double _abilityCooldownTimer = 0;

  CreatureType currentType = CreatureType.fire;

  PlayerComponent()
      : super(
    size: Vector2(64, 64),
    position: Vector2(100, groundY),
    paint: Paint()..color = AppColors.fireType,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
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
    } else {
      _isAbilityActive = false;
    }
  }

  void jump() {
    if (_isOnGround) {
      _velocityY = AppConstants.jumpForce;
      _isOnGround = false;
    }
  }

  void useAbility() {
    if (_abilityCooldownTimer > 0) return;

    _isAbilityActive = true;
    _abilityCooldownTimer = _getCooldown();

    switch (currentType) {
      case CreatureType.fire:
        _fireDash();
        break;
      case CreatureType.water:
        _waterGlide();
        break;
      case CreatureType.psychic:
        _psychicTeleport();
        break;
      case CreatureType.grass:
        _grassVineSwing();
        break;
    }
  }

  void swapCreature(CreatureType type) {
    currentType = type;
    paint.color = _getTypeColor();
  }

  void _fireDash() {
    position.x += 80;
  }

  void _waterGlide() {
    _velocityY = AppConstants.jumpForce * 0.5;
    _isOnGround = false;
  }

  void _psychicTeleport() {
    position.x += 120;
  }

  void _grassVineSwing() {
    _velocityY = AppConstants.jumpForce * 0.75;
    _isOnGround = false;
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

  Color _getTypeColor() {
    switch (currentType) {
      case CreatureType.fire:
        return AppColors.fireType;
      case CreatureType.water:
        return AppColors.waterType;
      case CreatureType.psychic:
        return AppColors.psychicType;
      case CreatureType.grass:
        return AppColors.grassType;
    }
  }

  double get abilityCooldownPercent =>
      _abilityCooldownTimer / _getCooldown();

  bool get isAbilityReady => _abilityCooldownTimer <= 0;
}