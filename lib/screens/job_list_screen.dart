import 'package:flutter/material.dart';

import '../models/job_application.dart';
import '../repositories/job_repository.dart';
import '../widgets/job_card.dart';
import 'job_form_screen.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key, required this.repository});

  final JobRepository repository;

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  JobStatus? _filter;

  @override
  void initState() {
    super.initState();
    widget.repository.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.repository.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  List<JobApplication> get _visibleJobs {
    final jobs = widget.repository.jobs;
    if (_filter == null) {
      return jobs;
    }

    return jobs.where((job) => job.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _visibleJobs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Tracker'),
        actions: [
          IconButton(
            tooltip: 'Add job',
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SummaryPanel(repository: widget.repository),
            const SizedBox(height: 16),
            _StatusFilter(
              selectedStatus: _filter,
              onChanged: (status) {
                setState(() => _filter = status);
              },
            ),
            const SizedBox(height: 16),
            if (jobs.isEmpty)
              _EmptyState(onAddPressed: () => _openForm(context))
            else
              ...jobs.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    job: job,
                    onTap: () => _openForm(context, job: job),
                    onDelete: () => _deleteJob(context, job),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Job'),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {JobApplication? job}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => JobFormScreen(repository: widget.repository, job: job),
      ),
    );
  }

  void _deleteJob(BuildContext context, JobApplication job) {
    widget.repository.remove(job.id);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${job.company} removed')));
  }
}

class _SummaryPanel extends StatelessWidget {
  const _SummaryPanel({required this.repository});

  final JobRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Application Pipeline',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${repository.totalCount} active opportunities',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.86),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: JobStatus.values.map((status) {
                return _SummaryChip(
                  label: status.label,
                  count: repository.countByStatus(status),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          '$label $count',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  const _StatusFilter({required this.selectedStatus, required this.onChanged});

  final JobStatus? selectedStatus;
  final ValueChanged<JobStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('All'),
              selected: selectedStatus == null,
              onSelected: (_) => onChanged(null),
            ),
          ),
          ...JobStatus.values.map(
            (status) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(status.label),
                selected: selectedStatus == status,
                onSelected: (_) => onChanged(status),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Icon(
              Icons.work_outline,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'No jobs here yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
              label: const Text('Add Job'),
            ),
          ],
        ),
      ),
    );
  }
}
