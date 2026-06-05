import 'package:flutter/foundation.dart';

import '../models/job_application.dart';

class JobRepository extends ChangeNotifier {
  JobRepository({List<JobApplication>? initialJobs})
    : _jobs = List.of(initialJobs ?? const []);

  factory JobRepository.seeded() {
    final today = DateTime.now();

    return JobRepository(
      initialJobs: [
        JobApplication(
          id: 'sample-1',
          company: 'Northstar Labs',
          role: 'Flutter Developer',
          status: JobStatus.interviewing,
          appliedDate: today.subtract(const Duration(days: 4)),
          location: 'Remote',
          notes: 'Prepare a short demo and review state management basics.',
        ),
        JobApplication(
          id: 'sample-2',
          company: 'BrightPath Systems',
          role: 'Mobile App Engineer',
          status: JobStatus.applied,
          appliedDate: today.subtract(const Duration(days: 10)),
          location: 'Bengaluru',
        ),
      ],
    );
  }

  final List<JobApplication> _jobs;

  List<JobApplication> get jobs {
    final sorted = List<JobApplication>.of(_jobs)
      ..sort((a, b) => b.appliedDate.compareTo(a.appliedDate));

    return List.unmodifiable(sorted);
  }

  int get totalCount => _jobs.length;

  int countByStatus(JobStatus status) {
    return _jobs.where((job) => job.status == status).length;
  }

  void add(JobApplication job) {
    _jobs.add(job);
    notifyListeners();
  }

  void update(JobApplication job) {
    final index = _jobs.indexWhere((current) => current.id == job.id);
    if (index == -1) {
      return;
    }

    _jobs[index] = job;
    notifyListeners();
  }

  void remove(String id) {
    _jobs.removeWhere((job) => job.id == id);
    notifyListeners();
  }
}
