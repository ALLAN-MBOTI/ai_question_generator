import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_model.dart';
import '../services/ai_service.dart';
import '../services/tracking_service.dart';
import 'auth_provider.dart';

// State class for Question Generation & Answering
class QuestionState {
  final bool isLoading;
  final List<Question> questions;
  final Map<String, String> studentAnswers;
  final String? errorMessage;
  final bool isGraded;

  QuestionState({
    this.isLoading = false,
    this.questions = const [],
    this.studentAnswers = const {},
    this.errorMessage,
    this.isGraded = false,
  });

  QuestionState copyWith({
    bool? isLoading,
    List<Question>? questions,
    Map<String, String>? studentAnswers,
    String? errorMessage,
    bool? isGraded,
  }) {
    return QuestionState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      studentAnswers: studentAnswers ?? this.studentAnswers,
      errorMessage: errorMessage,
      isGraded: isGraded ?? this.isGraded,
    );
  }
}

// Notifier to handle question generation and submission logic
class QuestionNotifier extends StateNotifier<QuestionState> {
  final AiService _aiService;
  final TrackingService _trackingService;
  final AuthState _authState;

  QuestionNotifier(this._aiService, this._trackingService, this._authState)
    : super(QuestionState());

  Future<void> generateQuestions(String topicPrompt, int count) async {
    if (topicPrompt.isEmpty) return;

    state = state.copyWith(isLoading: true, errorMessage: null, questions: []);

    try {
      final generatedQuestions = await _aiService.generateQuestions(
        topicPrompt: topicPrompt,
        count: count,
      );
      state = state.copyWith(isLoading: false, questions: generatedQuestions);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // Method to record a student's answer locally
  void recordAnswer(String questionId, String answerText) {
    if (state.isGraded) return;

    final updatedAnswers = Map<String, String>.from(state.studentAnswers);
    updatedAnswers[questionId] = answerText;

    state = state.copyWith(studentAnswers: updatedAnswers);
  }

  // Method to submit answers for grading and tracking
  Future<void> submitAnswers() async {
    if (state.questions.isEmpty || state.isGraded) return;

    final currentUser = _authState.user;
    if (currentUser == null) return;

    // 1. Calculate Score & Prepare Data
    int correctCount = 0;
    final details = state.questions.map((q) {
      final studentAnswer = state.studentAnswers[q.id] ?? 'No Answer';
      final isCorrect = studentAnswer == q.correctAnswer;
      if (isCorrect) correctCount++;

      return {
        'questionId': q.id,
        'chosenAnswer': studentAnswer,
        'correctAnswer': q.correctAnswer,
        'isCorrect': isCorrect,
      };
    }).toList();

    final performanceData = {
      'studentId': currentUser.id,
      'studentName': currentUser.name,
      'topic': state.questions.first.topic,
      'totalQuestions': state.questions.length,
      'score': correctCount,
      'details': details,
      'date': DateTime.now().toIso8601String(),
    };

    // 2. Call Tracking Service
    try {
      await _trackingService.savePerformance(performanceData);

      // 3. Update local state
      state = state.copyWith(isGraded: true, errorMessage: null);
    } catch (e) {
      state = state.copyWith(isGraded: true, errorMessage: e.toString());
    }
  }

  // Method to clear questions after a practice session is complete
  void clearQuestions() {
    state = QuestionState();
  }
}

// Riverpod Provider
final questionNotifierProvider =
    StateNotifierProvider<QuestionNotifier, QuestionState>((ref) {
      final aiService = ref.watch(aiServiceProvider);
      final trackingService = ref.watch(trackingServiceProvider);
      final authState = ref.watch(authNotifierProvider);

      return QuestionNotifier(aiService, trackingService, authState);
    });
