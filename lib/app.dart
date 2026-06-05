import 'package:flutter/material.dart';

import 'repositories/job_repository.dart';
import 'screens/job_list_screen.dart';

class JobTrackerApp extends StatelessWidget {
  const JobTrackerApp({super.key, required this.repository});

  final JobRepository repository;

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF1F7A5C);

    return MaterialApp(
      title: 'Job Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Color(0xFFE1E5EA)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: JobListScreen(repository: repository),
    );
  }
}
