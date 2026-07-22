import 'package:floreo_quiz_app/constants/app_colors.dart';
import 'package:floreo_quiz_app/constants/app_constants.dart';
import 'package:floreo_quiz_app/helper/responsive_helper.dart';
import 'package:floreo_quiz_app/widgets/k_filled_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedOption = -1;

  BoxShadow cardBgShadow = BoxShadow(
    blurRadius: 8,
    color: Colors.grey.withValues(alpha: 0.2),
    offset: const Offset(3, 3),
  );

  double? getQuestionCardRadius() {
    ScreenType screenType = ResponsiveHelper.getScreenType(context);
    return screenType == ScreenType.desktop ? 24 : null;
  }

  void selectAnswer(int option) => setState(() => selectedOption = option);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Floreo Quiz App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  buildQuestionCard(),
                  vSpace20,

                  ListView.separated(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => vSpace16,
                    itemBuilder: (context, index) => buildAnswerCard(index),
                  ),

                  vSpace20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KFilledButton(text: 'Prev', onPressed: () {}),
                      hSpace20,
                      KFilledButton(text: 'Next', onPressed: () {}),
                    ],
                  ),

                  vSpace20,
                  buildExplanationCard(),
                ],
              ),
            ),
            hSpace20,
            Expanded(
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
                        children: [Text('Question 1/8'), Text('Need Help?')],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: List.generate(20, (index) {
                          return buildNumberCard(index);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar buildNumberCard(int index) {
    return CircleAvatar(
      radius: getQuestionCardRadius(),
      backgroundColor: index == 12
          ? AppColors.red
          : index > 12
          ? AppColors.lightGrey
          : AppColors.lightBlue,
      child: Text(
        '${index + 1}',
        style: TextStyle(
          color: index == 12
              ? AppColors.white
              : index < 12
              ? AppColors.white
              : AppColors.black,
        ),
      ),
    );
  }

  Widget buildAnswerCard(int option) {
    return GestureDetector(
      onTap: () => selectAnswer(option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: selectedOption == option
              ? Border.all(color: AppColors.lightGrey, width: 2)
              : null,
          boxShadow: [cardBgShadow],
        ),
        child: const Text(
          '120 m',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Container buildQuestionCard() {
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
          const Text(
            'Question 1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Which programming language is primarily used for Flutter development?',
          ),
        ],
      ),
    );
  }

  Container buildExplanationCard() {
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
          const Text(
            'Which programming language is primarily used for Flutter development?',
          ),
        ],
      ),
    );
  }
}
