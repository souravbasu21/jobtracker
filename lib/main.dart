import 'package:flutter/material.dart';

import 'app.dart';
import 'repositories/job_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = await JobRepository.persistent();
  runApp(JobTrackerApp(repository: repository));
}
