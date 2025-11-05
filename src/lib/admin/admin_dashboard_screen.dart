// In lib/screens/admin/admin_dashboard_screen.dart
export '../parent/student_tracker_screen.dart'; // Re-use the display logic
// Create the wrapper class to use for routing in main.dart
import 'package:flutter/material.dart';
import '../parent/student_tracker_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Admins see a tracker view, potentially with extra controls.
    return const StudentTrackerScreen();
  }
}
