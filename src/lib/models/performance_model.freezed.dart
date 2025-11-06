// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestionResult _$QuestionResultFromJson(Map<String, dynamic> json) {
  return _QuestionResult.fromJson(json);
}

/// @nodoc
mixin _$QuestionResult {
  String get questionId => throw _privateConstructorUsedError;
  String get chosenAnswer => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this QuestionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionResultCopyWith<QuestionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionResultCopyWith<$Res> {
  factory $QuestionResultCopyWith(
          QuestionResult value, $Res Function(QuestionResult) then) =
      _$QuestionResultCopyWithImpl<$Res, QuestionResult>;
  @useResult
  $Res call(
      {String questionId,
      String chosenAnswer,
      String correctAnswer,
      bool isCorrect});
}

/// @nodoc
class _$QuestionResultCopyWithImpl<$Res, $Val extends QuestionResult>
    implements $QuestionResultCopyWith<$Res> {
  _$QuestionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? chosenAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      chosenAnswer: null == chosenAnswer
          ? _value.chosenAnswer
          : chosenAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionResultImplCopyWith<$Res>
    implements $QuestionResultCopyWith<$Res> {
  factory _$$QuestionResultImplCopyWith(_$QuestionResultImpl value,
          $Res Function(_$QuestionResultImpl) then) =
      __$$QuestionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String questionId,
      String chosenAnswer,
      String correctAnswer,
      bool isCorrect});
}

/// @nodoc
class __$$QuestionResultImplCopyWithImpl<$Res>
    extends _$QuestionResultCopyWithImpl<$Res, _$QuestionResultImpl>
    implements _$$QuestionResultImplCopyWith<$Res> {
  __$$QuestionResultImplCopyWithImpl(
      _$QuestionResultImpl _value, $Res Function(_$QuestionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? chosenAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(_$QuestionResultImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      chosenAnswer: null == chosenAnswer
          ? _value.chosenAnswer
          : chosenAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionResultImpl implements _QuestionResult {
  const _$QuestionResultImpl(
      {required this.questionId,
      required this.chosenAnswer,
      required this.correctAnswer,
      required this.isCorrect});

  factory _$QuestionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionResultImplFromJson(json);

  @override
  final String questionId;
  @override
  final String chosenAnswer;
  @override
  final String correctAnswer;
  @override
  final bool isCorrect;

  @override
  String toString() {
    return 'QuestionResult(questionId: $questionId, chosenAnswer: $chosenAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionResultImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.chosenAnswer, chosenAnswer) ||
                other.chosenAnswer == chosenAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, questionId, chosenAnswer, correctAnswer, isCorrect);

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionResultImplCopyWith<_$QuestionResultImpl> get copyWith =>
      __$$QuestionResultImplCopyWithImpl<_$QuestionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionResultImplToJson(
      this,
    );
  }
}

abstract class _QuestionResult implements QuestionResult {
  const factory _QuestionResult(
      {required final String questionId,
      required final String chosenAnswer,
      required final String correctAnswer,
      required final bool isCorrect}) = _$QuestionResultImpl;

  factory _QuestionResult.fromJson(Map<String, dynamic> json) =
      _$QuestionResultImpl.fromJson;

  @override
  String get questionId;
  @override
  String get chosenAnswer;
  @override
  String get correctAnswer;
  @override
  bool get isCorrect;

  /// Create a copy of QuestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionResultImplCopyWith<_$QuestionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Performance _$PerformanceFromJson(Map<String, dynamic> json) {
  return _Performance.fromJson(json);
}

/// @nodoc
mixin _$Performance {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  List<QuestionResult> get details => throw _privateConstructorUsedError;

  /// Serializes this Performance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerformanceCopyWith<Performance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceCopyWith<$Res> {
  factory $PerformanceCopyWith(
          Performance value, $Res Function(Performance) then) =
      _$PerformanceCopyWithImpl<$Res, Performance>;
  @useResult
  $Res call(
      {String id,
      String studentId,
      String studentName,
      DateTime date,
      String topic,
      int totalQuestions,
      int score,
      List<QuestionResult> details});
}

/// @nodoc
class _$PerformanceCopyWithImpl<$Res, $Val extends Performance>
    implements $PerformanceCopyWith<$Res> {
  _$PerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? date = null,
    Object? topic = null,
    Object? totalQuestions = null,
    Object? score = null,
    Object? details = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<QuestionResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceImplCopyWith<$Res>
    implements $PerformanceCopyWith<$Res> {
  factory _$$PerformanceImplCopyWith(
          _$PerformanceImpl value, $Res Function(_$PerformanceImpl) then) =
      __$$PerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentId,
      String studentName,
      DateTime date,
      String topic,
      int totalQuestions,
      int score,
      List<QuestionResult> details});
}

/// @nodoc
class __$$PerformanceImplCopyWithImpl<$Res>
    extends _$PerformanceCopyWithImpl<$Res, _$PerformanceImpl>
    implements _$$PerformanceImplCopyWith<$Res> {
  __$$PerformanceImplCopyWithImpl(
      _$PerformanceImpl _value, $Res Function(_$PerformanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? date = null,
    Object? topic = null,
    Object? totalQuestions = null,
    Object? score = null,
    Object? details = null,
  }) {
    return _then(_$PerformanceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      details: null == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<QuestionResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceImpl extends _Performance {
  const _$PerformanceImpl(
      {required this.id,
      required this.studentId,
      required this.studentName,
      required this.date,
      required this.topic,
      required this.totalQuestions,
      required this.score,
      required final List<QuestionResult> details})
      : _details = details,
        super._();

  factory _$PerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceImplFromJson(json);

  @override
  final String id;
  @override
  final String studentId;
  @override
  final String studentName;
  @override
  final DateTime date;
  @override
  final String topic;
  @override
  final int totalQuestions;
  @override
  final int score;
  final List<QuestionResult> _details;
  @override
  List<QuestionResult> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  @override
  String toString() {
    return 'Performance(id: $id, studentId: $studentId, studentName: $studentName, date: $date, topic: $topic, totalQuestions: $totalQuestions, score: $score, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentId,
      studentName,
      date,
      topic,
      totalQuestions,
      score,
      const DeepCollectionEquality().hash(_details));

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceImplCopyWith<_$PerformanceImpl> get copyWith =>
      __$$PerformanceImplCopyWithImpl<_$PerformanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceImplToJson(
      this,
    );
  }
}

abstract class _Performance extends Performance {
  const factory _Performance(
      {required final String id,
      required final String studentId,
      required final String studentName,
      required final DateTime date,
      required final String topic,
      required final int totalQuestions,
      required final int score,
      required final List<QuestionResult> details}) = _$PerformanceImpl;
  const _Performance._() : super._();

  factory _Performance.fromJson(Map<String, dynamic> json) =
      _$PerformanceImpl.fromJson;

  @override
  String get id;
  @override
  String get studentId;
  @override
  String get studentName;
  @override
  DateTime get date;
  @override
  String get topic;
  @override
  int get totalQuestions;
  @override
  int get score;
  @override
  List<QuestionResult> get details;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceImplCopyWith<_$PerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
