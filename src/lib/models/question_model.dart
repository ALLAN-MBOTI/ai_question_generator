import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

/// Represents a single generated question.
@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String topic, // The initial prompt topic
    required String text,
    required List<String> options, // Multiple choice options
    required String correctAnswer, // The correct answer text
    // Note: You could also add 'explanation' here
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
