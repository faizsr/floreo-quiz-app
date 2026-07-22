import 'package:floreo_quiz_app/config/responsive_helper.dart';
import 'package:floreo_quiz_app/constants/app_colors.dart';
import 'package:floreo_quiz_app/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionNumSelector extends StatefulWidget {
  const QuestionNumSelector({super.key});

  @override
  State<QuestionNumSelector> createState() => _QuestionNumSelectorState();
}

class _QuestionNumSelectorState extends State<QuestionNumSelector> {
  double getQuestionCardRadius() {
    ScreenType screenType = ResponsiveHelper.getScreenType(context);
    return screenType == ScreenType.desktop ? 24 : 20;
  }

  BoxShadow cardBgShadow = BoxShadow(
    blurRadius: 8,
    color: Colors.grey.withValues(alpha: 0.2),
    offset: const Offset(3, 3),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizController>(
      builder: (context, value, child) {
        int questionLen = value.quizQuestions.length;

        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [cardBgShadow],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${value.currentQuestion!.id}/$questionLen',
                      ),
                      Text('Need Help?'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(questionLen, (index) {
                      int questionNum = index + 1;
                      return buildNumberCard(questionNum, value);
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildNumberCard(int questionNum, QuizController value) {
    bool isWrong = false;
    bool isCorrect = false;
    int correctAnswer = value.quizQuestions[questionNum - 1].correctAnswer;
    String correctOption =
        value.quizQuestions[questionNum - 1].options[correctAnswer];

    bool isAttended = value.progress.selectedAnswers.containsKey(questionNum);
    if (isAttended) {
      String selectedOption = value.progress.selectedAnswers[questionNum]!;
      isCorrect = selectedOption == correctOption;
      isWrong = selectedOption != correctOption;
    }

    return GestureDetector(
      onTap: () => context.read<QuizController>().selectQuestion(questionNum),
      child: Container(
        height: getQuestionCardRadius() * 2,
        width: getQuestionCardRadius() * 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCorrect
              ? AppColors.lightBlue
              : isWrong
              ? AppColors.red
              : AppColors.lightGrey,
          border: value.currentQuestion?.id == questionNum
              ? Border.all(color: AppColors.black)
              : null,
        ),
        child: Text(
          '$questionNum',
          style: TextStyle(
            color: isCorrect
                ? AppColors.white
                : isWrong
                ? AppColors.white
                : AppColors.black,
          ),
        ),
      ),
    );
  }
}
