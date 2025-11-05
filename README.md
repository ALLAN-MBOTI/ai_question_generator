AI Question Generator: Project Readme

Welcome to #ai_question_generator, a dynamic educational project designed to enhance student learning through AI-powered question and answer generation, personalized practice, and comprehensive performance tracking.

📝 Project Overview

This application serves as a comprehensive platform for students, parents, and administrators. Its core functionality is generating customized questions and corresponding answers based on a user-provided topic prompt. This system aims to provide students with targeted practice and instant feedback, while giving parents and admins insightful data on progress.

💡 Usecase Scenario

Usecase: Personalized Math Practice

Scenario: A 7th-grade student, Alex, is struggling with the concept of Linear Equations.

    Student Action (Alex): Alex signs into the app, navigates to the AI Question Generator, and inputs the prompt: "Generate 10 practice questions on solving linear equations with one variable, suitable for a 7th grader."

    System Action: The backend API (powered by an AI model) processes the prompt and instantly returns a set of 10 unique questions and their correct, step-by-step answers.

    Interactive Practice: Alex attempts the questions directly in the app.

    System Action (Grading): The app automatically grades Alex's submission, highlights incorrect answers, and displays the correct solutions.

    Parent/Admin Action (Tracking): Alex's parent, Maria, signs into her account. She views Alex's performance dashboard, sees his latest score on "Linear Equations" (e.g., 6/10), identifies that he is struggling, and initiates a discussion with him about the weak areas indicated by the system. The Admin can view this performance alongside class-wide trends.

This use case demonstrates how the system provides targeted, on-demand practice and enables data-driven intervention by parents and administrators.

✨ Key Functionalities

    User Authentication: Secure Sign Up / Sign In system for all user roles (Student, Parent, Admin).

    AI Question Generation: Users provide a prompt or topic (e.g., "The water cycle") to generate customized questions and answers.

    Interactive Practice & Grading: Students answer the generated questions and receive instant, automated grading and feedback.

    Role-Based Performance Tracking: Admin and Parent users can track the student's performance, viewing detailed statistics, scores, and progress over time.

💻 Project Structure (Dart & Flutter)

The project follows a standard Flutter structure with a clear separation of concerns, utilizing packages for state management (e.g., Provider, Bloc, or Riverpod).

ai_question_generator/
├── android/
├── ios/
├── lib/
│ ├── main.dart # Entry point of the Flutter application
│ ├── config/ # Configuration files (API keys, constants, themes)
│ │ ├── app_constants.dart
│ │ └── theme_data.dart
│ ├── models/ # Data structures (Dart classes)
│ │ ├── user_model.dart # Student, Parent, Admin data structure
│ │ ├── question_model.dart
│ │ └── performance_report_model.dart
│ ├── services/ # Logic for communication with API/database (Backend)
│ │ ├── auth_service.dart # Sign-in/Sign-up logic
│ │ ├── ai_service.dart # Handles prompts and AI generation API calls
│ │ └── tracking_service.dart # Fetches student performance data
│ ├── providers/ # State Management (e.g., using Provider/Riverpod)
│ │ ├── auth_provider.dart
│ │ ├── question_provider.dart
│ │ └── performance_provider.dart
│ ├── screens/ # Full-page widgets (views)
│ │ ├── auth/
│ │ │ ├── sign_in_screen.dart
│ │ │ └── sign_up_screen.dart
│ │ ├── student/
│ │ │ ├── prompt_input_screen.dart
│ │ │ └── question_answering_screen.dart
│ │ ├── parent/
│ │ │ └── student_tracker_screen.dart
│ │ └── admin/
│ │ └── admin_dashboard_screen.dart
│ └── widgets/ # Reusable UI components
│ ├── custom_button.dart
│ ├── question_card.dart
│ └── performance_chart.dart
├── test/ # Unit and Widget tests
├── pubspec.yaml # Project dependencies and metadata
└── README.md # This file

🛠️ Technology Stack

    Frontend: Dart and Flutter (for cross-platform mobile and web application).

    Backend: A robust API (e.g., using Node.js/Express or Python/Django) to handle user authentication, database persistence, and communication with the AI model.

    AI/ML: [Specify Model/API, e.g., Gemini API, OpenAI API] for generating questions and answers.

    Database: [Specify DB, e.g., Firebase/Supabase, PostgreSQL] for storing user data, performance metrics, and past sessions.
