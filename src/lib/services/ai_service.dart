import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';
import '../models/question_model.dart';

class AiService {
  final Dio _dio;

  AiService(this._dio);

  /// Calls the backend API to generate questions based on a topic prompt.
  Future<List<Question>> generateQuestions({
    required String topicPrompt,
    required int count,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/ai/generate',
        data: {'topic': topicPrompt, 'count': count},
      );

      final List<dynamic> questionListJson = response.data['questions'];

      return questionListJson
          .map((json) => Question.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Question Generation Failed: ${e.response?.data['message'] ?? e.message}',
      );
    }
  }
}

// Riverpod Provider for AiService
final aiServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AiService(dio);
});
