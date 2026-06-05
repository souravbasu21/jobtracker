import 'package:flutter/material.dart';

import '../models/job_application.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final JobStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      JobStatus.wishlist => const Color(0xFF5D6B82),
      JobStatus.applied => const Color(0xFF2364AA),
      JobStatus.interviewing => const Color(0xFF8A5A00),
      JobStatus.offer => const Color(0xFF1F7A5C),
      JobStatus.rejected => const Color(0xFFB42318),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          status.label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
