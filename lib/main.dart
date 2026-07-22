import 'package:floreo_quiz_app/constants/app_theme.dart';
import 'package:floreo_quiz_app/controllers/quiz_controller.dart';
import 'package:floreo_quiz_app/models/quiz_progress_model.dart';
import 'package:floreo_quiz_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalDb();
  runApp(const MyApp());
}

Future<void> initializeLocalDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuizProgressModelAdapter());
  await Hive.openBox<QuizProgressModel>("quiz");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => QuizController())],
      child: MaterialApp(
        title: 'Floreo Quiz App',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
