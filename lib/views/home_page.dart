import 'package:floreo_quiz_app/config/responsive_helper.dart';
import 'package:floreo_quiz_app/constants/app_colors.dart';
import 'package:floreo_quiz_app/constants/app_constants.dart';
import 'package:floreo_quiz_app/controllers/quiz_controller.dart';
import 'package:floreo_quiz_app/models/quiz_question_model.dart';
import 'package:floreo_quiz_app/widgets/k_filled_button.dart';
import 'package:floreo_quiz_app/widgets/question_num_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuizController quizController;
  List<QuizQuestionModel> quizQuestions = [];

  BoxShadow cardBgShadow = BoxShadow(
    blurRadius: 8,
    color: Colors.grey.withValues(alpha: 0.2),
    offset: const Offset(3, 3),
  );

  void selectAnswer(int questionNum, String option) =>
      quizController.selectOption(questionNum, option);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quizController = context.read<QuizController>();
      quizController.initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floreo Quiz App'), centerTitle: true),
      body: Consumer<QuizController>(
        builder: (context, value, child) {
          if (value.currentQuestion == null) return SizedBox();

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
                      buildQuestionCard(value.currentQuestion!),
                      vSpace20,

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.currentQuestion!.options.length,
                        separatorBuilder: (context, index) => vSpace16,
                        itemBuilder: (context, index) => buildAnswerCard(
                          value.currentQuestion!.options[index],
                          value,
                        ),
                      ),

                      vSpace12,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Note: Your answer will be locked after selection and cannot be modified.',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: AppColors.lightGrey),
                        ),
                      ),

                      vSpace12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KFilledButton(
                            text: 'Prev',
                            onPressed: () {
                              int currentQuestionNo = value.currentQuestion!.id;
                              value.selectQuestion(currentQuestionNo - 1);
                            },
                          ),
                          hSpace20,
                          KFilledButton(
                            text: 'Next',
                            onPressed: () {
                              int currentQuestionNo = value.currentQuestion!.id;
                              value.selectQuestion(currentQuestionNo + 1);
                            },
                          ),
                        ],
                      ),

                      // ------- Checking if answer is selected before displaying explanation -------
                      if (value.progress.selectedAnswers.containsKey(
                        value.currentQuestion!.id,
                      )) ...[
                        vSpace20,
                        buildExplanationCard(value.currentQuestion!),
                      ],

                      if (!ResponsiveHelper.isDesktop(context)) ...[
                        vSpace20,
                        QuestionNumSelector(),
                      ],
                    ],
                  ),
                ),

                if (ResponsiveHelper.isDesktop(context)) ...[
                  hSpace20,
                  Expanded(child: QuestionNumSelector()),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildAnswerCard(String option, QuizController value) {
    return GestureDetector(
      onTap: () => selectAnswer(value.currentQuestion!.id, option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border:
              value.progress.selectedAnswers[value.currentQuestion!.id] ==
                  option
              ? Border.all(color: AppColors.lightGrey, width: 2)
              : null,
          boxShadow: [cardBgShadow],
        ),
        child: Text(option),
      ),
    );
  }

  Container buildQuestionCard(QuizQuestionModel question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${question.id}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(question.question),
        ],
      ),
    );
  }

  Container buildExplanationCard(QuizQuestionModel question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [cardBgShadow],
      ),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explanation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(question.explanation),
        ],
      ),
    );
  }
}
