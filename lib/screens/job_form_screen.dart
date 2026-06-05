import 'package:flutter/material.dart';

import '../models/job_application.dart';
import '../repositories/job_repository.dart';

class JobFormScreen extends StatefulWidget {
  const JobFormScreen({super.key, required this.repository, this.job});

  final JobRepository repository;
  final JobApplication? job;

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _companyController;
  late final TextEditingController _roleController;
  late final TextEditingController _locationController;
  late final TextEditingController _notesController;
  late JobStatus _status;
  late DateTime _appliedDate;

  bool get _isEditing => widget.job != null;

  @override
  void initState() {
    super.initState();
    final job = widget.job;

    _companyController = TextEditingController(text: job?.company ?? '');
    _roleController = TextEditingController(text: job?.role ?? '');
    _locationController = TextEditingController(text: job?.location ?? '');
    _notesController = TextEditingController(text: job?.notes ?? '');
    _status = job?.status ?? JobStatus.wishlist;
    _appliedDate = job?.appliedDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Job' : 'Add Job')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _companyController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Company',
                  prefixIcon: Icon(Icons.business_outlined),
                ),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _roleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<JobStatus>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: JobStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.label),
                  );
                }).toList(),
                onChanged: (status) {
                  if (status == null) {
                    return;
                  }

                  setState(() => _status = status);
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text('Applied ${_formatDate(_appliedDate)}'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: Text(_isEditing ? 'Save Changes' : 'Create Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _appliedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked == null) {
      return;
    }

    setState(() => _appliedDate = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final existing = widget.job;
    final job = JobApplication(
      id: existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      company: _companyController.text.trim(),
      role: _roleController.text.trim(),
      status: _status,
      appliedDate: _appliedDate,
      location: _locationController.text.trim(),
      notes: _notesController.text.trim(),
    );

    if (existing == null) {
      widget.repository.add(job);
    } else {
      widget.repository.update(job);
    }

    Navigator.of(context).pop();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
