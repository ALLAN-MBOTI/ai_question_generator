import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../models/question_model.dart';

class AiService {
  final Dio _dio;
  // In a real app, you'd inject the current user token into Dio headers here

  AiService(this._dio);

  /// Calls the backend API to generate questions based on a topic prompt.
  Future<List<Question>> generateQuestions({
    required String topicPrompt,
    required int count,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/ai/generate',
        data: {
          'topic': topicPrompt,
          'count': count,
          // You might include user role/level for context-aware generation
        },
      );

      // Assuming the API returns a list of question maps
      final List<dynamic> questionListJson = response.data['questions'];

      return questionListJson
          .map((json) => Question.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      // Detailed error reporting
      throw Exception(
        'Question Generation Failed: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }
}

// Riverpod Provider for AiService
final aiServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider); // Re-use the Dio instance
  return AiService(dio);
});
