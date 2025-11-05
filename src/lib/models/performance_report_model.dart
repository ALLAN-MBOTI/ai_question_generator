import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_model.freezed.dart';
part 'performance_model.g.dart';

/// Represents a single question's details within a performance session.
@freezed
class QuestionResult with _$QuestionResult {
  const factory QuestionResult({
    required String questionId,
    required String chosenAnswer,
    required String correctAnswer, // Include the correct answer for review
    required bool isCorrect,
  }) = _QuestionResult;

  factory QuestionResult.fromJson(Map<String, dynamic> json) =>
      _$QuestionResultFromJson(json);
}

/// Represents a student's performance on a single practice session.
@freezed
class Performance with _$Performance {
  const factory Performance({
    required String id,
    required String studentId, // Who took the test
    required String studentName,
    required DateTime date,
    required String topic,
    required int totalQuestions,
    required int score, // Number of correct answers
    required List<QuestionResult> details,
  }) = _Performance;

  /// Helper to calculate the percentage score
  @JsonKey(ignore: true)
  double get percentage => (score / totalQuestions) * 100;

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);
}
