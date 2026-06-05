# Job Tracker

A minimally viable Flutter application for tracking job applications. The app is intentionally simple and dependency-light so it can be used as a clean template for future Flutter projects.

## Overview

Job Tracker helps users maintain a small application pipeline with company, role, location, status, applied date, and notes. It stores the job list locally using SharedPreferences, which keeps the project easy to understand for beginners and simple to extend later with SQLite, Firebase, REST APIs, or a more advanced state management approach.

## Features

- View a list of job applications
- Add a new job application
- Edit an existing job application
- Delete an application
- Track application status:
  - Wishlist
  - Applied
  - Interviewing
  - Offer
  - Rejected
- Filter jobs by status
- View a summary of applications by status
- Persist jobs locally after the app is closed
- Basic widget test for the add-job flow

## Tech Stack

- Flutter
- Dart
- Material 3
- ChangeNotifier for simple local state updates
- SharedPreferences for local persistence
- Flutter widget testing

## Project Structure

```text
lib/
  main.dart
  app.dart
  models/
    job_application.dart
  repositories/
    job_repository.dart
  services/
    job_storage.dart
  screens/
    job_list_screen.dart
    job_form_screen.dart
  widgets/
    job_card.dart
    status_badge.dart
test/
  widget_test.dart
```

### Key Files

- `lib/main.dart` starts the Flutter app.
- `lib/app.dart` defines the root `MaterialApp`, theme, and first screen.
- `lib/models/job_application.dart` contains the job data model and status enum.
- `lib/repositories/job_repository.dart` manages the in-memory job list.
- `lib/services/job_storage.dart` saves and loads jobs with SharedPreferences.
- `lib/screens/job_list_screen.dart` displays the dashboard, filters, and job cards.
- `lib/screens/job_form_screen.dart` handles adding and editing jobs.
- `lib/widgets/job_card.dart` renders a single job application card.
- `lib/widgets/status_badge.dart` renders the colored status label.
- `test/widget_test.dart` verifies that a user can add a job.

## Getting Started

### Prerequisites

Install the following:

- Flutter SDK
- Android Studio
- Android emulator or physical Android device
- Git, if you plan to push the project to GitHub

### Run the App

Open the project folder in Android Studio:

```text
C:\Flutter Projects\jobtracker
```

Then select an emulator or connected device and press Run.

You can also run from terminal:

```powershell
flutter pub get
flutter run
```

## Testing

Run the widget test:

```powershell
flutter test
```

Run static analysis:

```powershell
flutter analyze
```

Format the project:

```powershell
dart format lib test
```

## Current Limitations

- Data is stored locally on the device only.
- There is no authentication.
- There is no backend or cloud sync yet.
- SharedPreferences is suitable for small local data. For larger datasets, SQLite or Drift would be a better fit.

## Possible Next Improvements

- Replace SharedPreferences with SQLite, Drift, Hive, or Firebase for larger apps
- Add search
- Add due dates and reminders
- Add company/contact details
- Add analytics for applications by week or status
- Add a proper state management package such as Provider, Riverpod, or Bloc
- Add more widget and repository tests

## Purpose

This project is designed as both a small functional app and a beginner-friendly Flutter template, especially for developers coming from Android Kotlin/native development.
