import 'package:hive_flutter/hive_flutter.dart';
import '../models/creature_model.dart';
import '../models/score_model.dart';

class HiveService {
  static const String scoreBox = 'score_box';
  static const String creaturesBox = 'creatures_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(CreatureModelAdapter());
    Hive.registerAdapter(ScoreModelAdapter());

    // Open boxes
    await Hive.openBox<ScoreModel>(scoreBox);
    await Hive.openBox<CreatureModel>(creaturesBox);
  }

  static Box<ScoreModel> get scores => Hive.box<ScoreModel>(scoreBox);
  static Box<CreatureModel> get creatures => Hive.box<CreatureModel>(creaturesBox);
}