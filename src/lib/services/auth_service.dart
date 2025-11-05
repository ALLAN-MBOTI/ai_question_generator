import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_constants.dart';
import '../models/user_model.dart';

class AuthService {
  final Dio _dio;
  final SharedPreferences _prefs;

  AuthService(this._dio, this._prefs);

  // --- Utility for Local Storage ---

  Future<void> _saveUserSession(User user, String token) async {
    await _prefs.setString(AppConstants.userTokenKey, token);
    await _prefs.setString(AppConstants.userDataKey, jsonEncode(user.toJson()));
  }

  Future<void> clearUserSession() async {
    await _prefs.remove(AppConstants.userTokenKey);
    await _prefs.remove(AppConstants.userDataKey);
  }

  // --- API Methods ---

  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/login',
        data: {'email': email, 'password': password},
      );

      // Assuming API returns {'user': {...}, 'token': '...'}
      final token = response.data['token'] as String;
      final userJson = response.data['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson).copyWith(token: token);

      await _saveUserSession(user, token);
      return user;
    } on DioException catch (e) {
      // Custom error handling for Dio (e.g., status codes, network errors)
      throw Exception(
        'Sign In Failed: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role.toJson(), // Use the enum's JSON value
        },
      );

      final token = response.data['token'] as String;
      final userJson = response.data['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson).copyWith(token: token);

      await _saveUserSession(user, token);
      return user;
    } on DioException catch (e) {
      throw Exception(
        'Sign Up Failed: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }

  // Initial check to see if a user is already logged in
  Future<User?> checkAuthStatus() async {
    final token = _prefs.getString(AppConstants.userTokenKey);
    final userJsonString = _prefs.getString(AppConstants.userDataKey);

    if (token != null && userJsonString != null) {
      try {
        final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;
        return User.fromJson(userJson).copyWith(token: token);
      } catch (_) {
        await clearUserSession();
        return null;
      }
    }
    return null;
  }

  Future<void> signOut() async {
    // In a real app, you might call a /logout endpoint here
    await clearUserSession();
  }
}
