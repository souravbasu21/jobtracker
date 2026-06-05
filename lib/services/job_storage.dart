import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/job_application.dart';

class JobStorage {
  static const _jobsKey = 'job_applications';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<List<JobApplication>?> loadJobs() async {
    final savedJobs = await _preferences.getString(_jobsKey);
    if (savedJobs == null) {
      return null;
    }

    final decoded = jsonDecode(savedJobs);
    if (decoded is! List) {
      return const [];
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(JobApplication.fromJson)
        .toList();
  }

  Future<void> saveJobs(List<JobApplication> jobs) {
    final encodedJobs = jsonEncode(jobs.map((job) => job.toJson()).toList());

    return _preferences.setString(_jobsKey, encodedJobs);
  }
}
