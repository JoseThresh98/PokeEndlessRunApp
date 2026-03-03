import 'package:flutter/material.dart';
import '../../core/constants/creature_type.dart';
import '../../core/theme/app_colors.dart';
import '../../game/biome_run_game.dart';
import '../../data/repositories/creature_repository.dart';
import '../../data/models/creature_model.dart';

class CreatureSwapBar extends StatefulWidget {
  final BiomeRunGame game;

  const CreatureSwapBar({super.key, required this.game});

  @override
  State<CreatureSwapBar> createState() => _CreatureSwapBarState();
}

class _CreatureSwapBarState extends State<CreatureSwapBar> {
  CreatureType _selected = CreatureType.fire;
  List<CreatureModel> _creatures = [];

  @override
  void initState() {
    super.initState();
    _loadCreatures();
  }

  void _loadCreatures() {
    final repo = CreatureRepository();
    setState(() {
      _creatures = repo.getAllCreatures();
    });
  }

  bool _isUnlocked(CreatureType type) {
    return _creatures
        .where((c) => c.type == type && c.isUnlocked)
        .isNotEmpty;
  }

  Color _typeColor(CreatureType type) {
    switch (type) {
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

  String _typeEmoji(CreatureType type) {
    switch (type) {
      case CreatureType.fire:
        return '🔥';
      case CreatureType.water:
        return '💧';
      case CreatureType.psychic:
        return '🔮';
      case CreatureType.grass:
        return '🌿';
    }
  }

  String _typeName(CreatureType type) {
    switch (type) {
      case CreatureType.fire:
        return 'Emberon';
      case CreatureType.water:
        return 'Aquafin';
      case CreatureType.psychic:
        return 'Psywyn';
      case CreatureType.grass:
        return 'Thornveil';
    }
  }

  void _swap(CreatureType type) {
    if (!_isUnlocked(type)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_typeName(type)} is locked! Unlock in the shop.'),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }
    setState(() => _selected = type);
    widget.game.player.swapCreature(type);
  }

  void _useAbility() {
    widget.game.player.useAbility();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // Ability button
          GestureDetector(
            onTap: _useAbility,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: _typeColor(_selected).withValues(alpha: 0.9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: _typeColor(_selected).withValues(alpha: 0.6),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _typeEmoji(_selected),
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Creature swap row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: CreatureType.values.map((type) {
              final isSelected = _selected == type;
              final unlocked = _isUnlocked(type);
              return GestureDetector(
                onTap: () => _swap(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: isSelected ? 64 : 52,
                  height: isSelected ? 64 : 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _typeColor(type)
                        : unlocked
                        ? _typeColor(type).withValues(alpha: 0.4)
                        : Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: _typeColor(type).withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        unlocked ? _typeEmoji(type) : '🔒',
                        style: TextStyle(
                          fontSize: isSelected ? 22 : 18,
                        ),
                      ),
                      Text(
                        _typeName(type),
                        style: TextStyle(
                          color: unlocked ? Colors.white : Colors.grey,
                          fontSize: 7,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}