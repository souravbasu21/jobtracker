enum JobStatus {
  wishlist('Wishlist'),
  applied('Applied'),
  interviewing('Interviewing'),
  offer('Offer'),
  rejected('Rejected');

  const JobStatus(this.label);

  final String label;

  static JobStatus fromName(String name) {
    return JobStatus.values.firstWhere(
      (status) => status.name == name,
      orElse: () => JobStatus.wishlist,
    );
  }
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

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String? ?? '',
      company: json['company'] as String? ?? '',
      role: json['role'] as String? ?? '',
      status: JobStatus.fromName(json['status'] as String? ?? ''),
      appliedDate:
          DateTime.tryParse(json['appliedDate'] as String? ?? '') ??
          DateTime.now(),
      location: json['location'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'role': role,
      'status': status.name,
      'appliedDate': appliedDate.toIso8601String(),
      'location': location,
      'notes': notes,
    };
  }
}
