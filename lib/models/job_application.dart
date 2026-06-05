enum JobStatus {
  wishlist('Wishlist'),
  applied('Applied'),
  interviewing('Interviewing'),
  offer('Offer'),
  rejected('Rejected');

  const JobStatus(this.label);

  final String label;
}

class JobApplication {
  const JobApplication({
    required this.id,
    required this.company,
    required this.role,
    required this.status,
    required this.appliedDate,
    this.location = '',
    this.notes = '',
  });

  final String id;
  final String company;
  final String role;
  final JobStatus status;
  final DateTime appliedDate;
  final String location;
  final String notes;

  JobApplication copyWith({
    String? id,
    String? company,
    String? role,
    JobStatus? status,
    DateTime? appliedDate,
    String? location,
    String? notes,
  }) {
    return JobApplication(
      id: id ?? this.id,
      company: company ?? this.company,
      role: role ?? this.role,
      status: status ?? this.status,
      appliedDate: appliedDate ?? this.appliedDate,
      location: location ?? this.location,
      notes: notes ?? this.notes,
    );
  }
}
