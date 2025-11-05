import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/student/prompt_input_screen.dart'; // Placeholder
import 'screens/parent/student_tracker_screen.dart'; // Placeholder
import 'screens/admin/admin_dashboard_screen.dart'; // Placeholder
import 'models/user_model.dart';

void main() {
  // Ensure Flutter binding is initialized before SharedPreferences is loaded
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // Wrap the app with ProviderScope for Riverpod
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the authentication state from the Notifier
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'AI Question Generator',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Use the router based on the authentication state
      home: _getHome(authState),
    );
  }

  Widget _getHome(AuthState state) {
    if (state.isLoading) {
      // Show loading screen while checking local session
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!state.isAuthenticated) {
      // User is not logged in, go to Sign In screen
      return const SignInScreen();
    }

    // User is logged in, navigate based on role
    switch (state.user!.role) {
      case UserRole.student:
        return const PromptInputScreen(); // Student Landing Page
      case UserRole.parent:
        return const StudentTrackerScreen(); // Parent Landing Page
      case UserRole.admin:
        return const AdminDashboardScreen(); // Admin Landing Page
      default:
        // Fallback, should not happen
        return const SignInScreen();
    }
  }
}
