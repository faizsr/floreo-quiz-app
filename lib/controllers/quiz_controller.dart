import 'dart:convert';

import 'package:floreo_quiz_app/models/quiz_progress_model.dart';
import 'package:floreo_quiz_app/models/quiz_question_model.dart';
import 'package:floreo_quiz_app/services/quiz_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizController extends ChangeNotifier {
  // String selectedOption = '';
  QuizQuestionModel? currentQuestion;
  List<QuizQuestionModel> quizQuestions = [];

  late QuizProgressModel progress;

  Future<void> initialize() async {
    await getQuizQuestions();

    progress =
        QuizStorage.load() ??
        QuizProgressModel(currentQuestionNum: 1, selectedAnswers: {});

    currentQuestion = quizQuestions[0];

    notifyListeners();
  }

  Future<void> getQuizQuestions() async {
    final jsonString = await rootBundle.loadString('quiz_data.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    quizQuestions = jsonList
        .map((json) => QuizQuestionModel.fromJson(json))
        .toList();
    currentQuestion = quizQuestions.first;
    notifyListeners();
  }

  void selectOption(int questionNum, String option) async {
    if (progress.selectedAnswers.containsKey(questionNum)) {
      return;
    }
    progress.selectedAnswers[questionNum] = option;
    progress.currentQuestionNum = questionNum;

    await QuizStorage.save(progress);
    notifyListeners();
  }

  void selectQuestion(int questionNum) {
    if (questionNum < 1 || questionNum > quizQuestions.length) return;

    currentQuestion = quizQuestions[questionNum - 1];
    notifyListeners();
  }
}
