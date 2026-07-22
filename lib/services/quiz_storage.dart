import 'package:floreo_quiz_app/models/quiz_progress_model.dart';
import 'package:hive_ce/hive.dart';

class QuizStorage {
  static const String boxName = "quiz";
  static const String progressKey = "progress";

  static Box<QuizProgressModel> get box => Hive.box<QuizProgressModel>(boxName);

  static Future<void> save(QuizProgressModel progress) async {
    await box.put(progressKey, progress);
  }

  static QuizProgressModel? load() {
    return box.get(progressKey);
  }

  static Future<void> clear() async {
    await box.clear();
  }
}
