// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionResultImpl _$$QuestionResultImplFromJson(Map<String, dynamic> json) =>
    _$QuestionResultImpl(
      questionId: json['questionId'] as String,
      chosenAnswer: json['chosenAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$$QuestionResultImplToJson(
        _$QuestionResultImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'chosenAnswer': instance.chosenAnswer,
      'correctAnswer': instance.correctAnswer,
      'isCorrect': instance.isCorrect,
    };

_$PerformanceImpl _$$PerformanceImplFromJson(Map<String, dynamic> json) =>
    _$PerformanceImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      date: DateTime.parse(json['date'] as String),
      topic: json['topic'] as String,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      details: (json['details'] as List<dynamic>)
          .map((e) => QuestionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PerformanceImplToJson(_$PerformanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'date': instance.date.toIso8601String(),
      'topic': instance.topic,
      'totalQuestions': instance.totalQuestions,
      'score': instance.score,
      'details': instance.details,
    };
