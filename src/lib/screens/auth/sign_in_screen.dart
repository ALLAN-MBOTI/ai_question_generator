import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authNotifier = ref.read(authNotifierProvider.notifier);
      // Calls the sign-in logic, state updates automatically via Riverpod
      await authNotifier.signIn(email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state for loading and error messages
    final authState = ref.watch(authNotifierProvider);

    // Listen for error messages and show a SnackBar
    ref.listen<AuthState>(authNotifierProvider, (previous, current) {
      if (current.errorMessage != null && !current.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty || !value.contains('@')
                      ? 'Enter a valid email'
                      : null,
                  onSaved: (value) => _email = value!.trim(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                if (authState.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Sign In'),
                  ),
                const SizedBox(height: 10),
                // Button to navigate to Sign Up (if you implement routing)
                TextButton(
                  onPressed: () {
                    // TODO: Implement navigation to SignUpScreen
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
