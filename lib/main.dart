import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'data/local/hive_service.dart';
import 'data/repositories/score_repository.dart';
import 'data/repositories/creature_repository.dart';
import 'game/biome_run_game.dart';
import 'presentation/screens/main_menu_screen.dart';
import 'presentation/screens/game_over_screen.dart';
import 'presentation/screens/shop_screen.dart';
import 'presentation/widgets/creature_swap_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const PokeRunApp());
}

class PokeRunApp extends StatelessWidget {
  const PokeRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        canvasColor: const Color(0xFF1A1A2E),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF1A1A2E),
        ),
      ),
      color: const Color(0xFF1A1A2E),
      home: const AppNavigator(),
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  final CreatureRepository _creatureRepository = CreatureRepository();

  String _screen = 'menu';
  BiomeRunGame? _game;
  int _gameKey = 0;

  void _goToGame() {
    setState(() {
      _gameKey++;
      _game = BiomeRunGame(
        scoreRepository: _scoreRepository,
        onGameOver: _goToGameOver,
      );
      _screen = 'game';
    });
  }

  void _goToGameOver() {
    setState(() {
      _screen = 'gameover';
    });
  }

  void _restartGame() {
    setState(() {
      _gameKey++;
      _game = BiomeRunGame(
        scoreRepository: _scoreRepository,
        onGameOver: _goToGameOver,
      );
      _screen = 'game';
    });
  }

  void _goToMenu() {
    setState(() {
      _screen = 'menu';
      _game = null;
    });
  }

  void _goToShop() {
    setState(() => _screen = 'shop');
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (_screen) {
      case 'game':
        screen = Scaffold(
          body: Stack(
            children: [
              GameWidget(
                key: ValueKey(_gameKey),
                game: _game!,
              ),
              CreatureSwapBar(game: _game!),
            ],
          ),
        );
        break;
      case 'gameover':
        screen = GameOverScreen(
          game: _game!,
          scoreRepository: _scoreRepository,
          onRestart: _restartGame,
          onMenu: _goToMenu,
        );
        break;
      case 'shop':
        screen = ShopScreen(
          scoreRepository: _scoreRepository,
          creatureRepository: _creatureRepository,
          onBack: _goToMenu,
        );
        break;
      default:
        screen = MainMenuScreen(
          scoreRepository: _scoreRepository,
          onPlay: _goToGame,
          onShop: _goToShop,
        );
    }

    return Container(
      color: const Color(0xFF1A1A2E),
      child: screen,
    );
  }
}