import 'package:flutter/material.dart';
import '../../core/constants/creature_type.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/creature_model.dart';
import '../../data/repositories/creature_repository.dart';
import '../../data/repositories/score_repository.dart';

class ShopScreen extends StatefulWidget {
  final ScoreRepository scoreRepository;
  final CreatureRepository creatureRepository;
  final VoidCallback onBack;

  const ShopScreen({
    super.key,
    required this.scoreRepository,
    required this.creatureRepository,
    required this.onBack,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late List<CreatureModel> _creatures;
  late int _totalCoins;
  late int _totalGems;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _creatures = widget.creatureRepository.getAllCreatures();
      _totalCoins = widget.scoreRepository.getScore().totalCoins;
      _totalGems = widget.scoreRepository.getScore().totalGems;
    });
  }

  Color _typeColor(int typeIndex) {
    switch (CreatureType.values[typeIndex]) {
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

  String _typeEmoji(int typeIndex) {
    switch (CreatureType.values[typeIndex]) {
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

  Future<void> _unlock(CreatureModel creature) async {
    if (creature.requiresGems) {
      if (_totalGems < creature.gemCost) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Need 💎 ${creature.gemCost} gems! You have $_totalGems.'),
            backgroundColor: AppColors.accent,
          ),
        );
        return;
      }
      await widget.scoreRepository.spendGems(creature.gemCost);
      await widget.creatureRepository.unlockCreature(creature.id);
      _refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${creature.name} unlocked! 🔮'),
            backgroundColor: AppColors.psychicType,
          ),
        );
      }
      return;
    }

    if (_totalCoins < creature.unlockCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins!'),
          backgroundColor: AppColors.accent,
        ),
      );
      return;
    }
    await widget.scoreRepository.spendCoins(creature.unlockCost);
    await widget.creatureRepository.unlockCreature(creature.id);
    _refresh();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${creature.name} unlocked!'),
          backgroundColor: AppColors.grassType,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.onBack,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'SHOP',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                  // Coins + Gems display
                  Row(
                    children: [
                      const Text('🪙', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        '$_totalCoins',
                        style: const TextStyle(
                          color: AppColors.coinColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text('💎', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        '$_totalGems',
                        style: const TextStyle(
                          color: AppColors.gemColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.primary),

            // Creatures grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _creatures.length,
                itemBuilder: (context, index) {
                  final creature = _creatures[index];
                  final color = _typeColor(creature.typeIndex);
                  final emoji = _typeEmoji(creature.typeIndex);
                  final isUnlocked = creature.isUnlocked;
                  final canAfford = _totalCoins >= creature.unlockCost;
                  final canAffordGems = _totalGems >= creature.gemCost; // ← fixed

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isUnlocked ? color : AppColors.primary,
                        width: 2,
                      ),
                      boxShadow: isUnlocked
                          ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                          : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Creature emoji/icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: color.withValues(
                                alpha: isUnlocked ? 0.3 : 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              isUnlocked ? emoji : '🔒',
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Name
                        Text(
                          creature.name,
                          style: TextStyle(
                            color: isUnlocked ? color : AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Type ability name
                        Text(
                          creature.type.abilityName,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Button
                        if (isUnlocked)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color),
                            ),
                            child: const Text(
                              'UNLOCKED',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () => _unlock(creature),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: creature.requiresGems
                                    ? (canAffordGems
                                    ? AppColors.psychicType
                                    : AppColors.primary)
                                    : (canAfford
                                    ? AppColors.accent
                                    : AppColors.primary),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    creature.requiresGems ? '💎' : '🪙',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    creature.requiresGems
                                        ? '${creature.gemCost}'
                                        : '${creature.unlockCost}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}