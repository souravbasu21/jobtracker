import 'package:flutter/material.dart';

import 'app.dart';
import 'repositories/job_repository.dart';

void main() {
  runApp(JobTrackerApp(repository: JobRepository.seeded()));
}
