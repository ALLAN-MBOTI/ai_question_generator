import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

// 1. Define the Authentication State
class AuthState {
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.user, this.errorMessage});

  bool get isAuthenticated => user != null;

  AuthState copyWith({bool? isLoading, User? user, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

// 2. Define the Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState()) {
    _loadInitialUser();
  }

  Future<void> _loadInitialUser() async {
    state = state.copyWith(isLoading: true);
    final user = await _authService.checkAuthStatus();
    state = state.copyWith(isLoading: false, user: user);
  }

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _authService.signIn(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _authService.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = AuthState(); // Reset state to initial unauthenticated state
  }
}

// 3. Define the Providers
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final dioProvider = Provider((ref) => Dio());

final authServiceProvider = Provider<AuthService>((ref) {
  // Use .when to wait for sharedPreferencesProvider to resolve
  final prefsAsync = ref.watch(sharedPreferencesProvider);
  final dio = ref.watch(dioProvider);

  return prefsAsync.when(
    data: (prefs) => AuthService(dio, prefs),
    loading: () => throw Exception("SharedPreferences not loaded yet"),
    error: (err, stack) =>
        throw Exception("Failed to load SharedPreferences: $err"),
  );
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
