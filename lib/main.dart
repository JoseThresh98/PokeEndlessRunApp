import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'data/local/hive_service.dart';
import 'data/repositories/score_repository.dart';
import 'game/biome_run_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  final scoreRepository = ScoreRepository();
  final game = BiomeRunGame(scoreRepository: scoreRepository);

  runApp(GameWidget(game: game));
}