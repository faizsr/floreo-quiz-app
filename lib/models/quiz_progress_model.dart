import 'package:hive_ce/hive.dart';

part 'quiz_progress_model.g.dart';

@HiveType(typeId: 0)
class QuizProgressModel extends HiveObject {
  @HiveField(0)
  int currentQuestionNum;

  @HiveField(1)
  Map<int, String> selectedAnswers;

  QuizProgressModel({
    required this.currentQuestionNum,
    required this.selectedAnswers,
  });
}
