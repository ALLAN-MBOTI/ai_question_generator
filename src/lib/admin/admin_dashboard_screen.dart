import 'package:flutter/material.dart';
import '../parent/student_tracker_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Admins use the tracker screen, which will automatically fetch system-wide data
    return const StudentTrackerScreen();
  }
}
