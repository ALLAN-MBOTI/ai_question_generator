import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../models/performance_model.dart';
import '../models/user_model.dart'; // To get the current user's ID/Role

class TrackingService {
  final Dio _dio;

  TrackingService(this._dio);

  /// Saves the results of a single practice session.
  Future<void> savePerformance(Map<String, dynamic> performanceData) async {
    try {
      // This endpoint receives the raw results from the student's submission.
      await _dio.post(
        '${AppConstants.baseUrl}/performance/save',
        data: performanceData,
      );
    } on DioException catch (e) {
      throw Exception(
        'Failed to save performance: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }

  /// Fetches a list of performances based on the user's role.
  /// - Student: Fetches their own history.
  /// - Parent: Fetches history of their linked students.
  /// - Admin: Fetches all performance history.
  Future<List<Performance>> getPerformances({
    required UserRole userRole,
    required String userId,
  }) async {
    try {
      // The backend should use the token/userId to determine the correct scope (Parent/Admin/Student)
      final response = await _dio.get(
        '${AppConstants.baseUrl}/performance/list',
        queryParameters: {'userRole': userRole.name, 'userId': userId},
      );

      final List<dynamic> performanceListJson = response.data['performances'];

      return performanceListJson
          .map((json) => Performance.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch performances: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }
}

// Riverpod Provider for TrackingService
final trackingServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return TrackingService(dio);
});
