import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_model.dart';
import '../services/ai_service.dart';

// State class for Question Generation
class QuestionState {
  final bool isLoading;
  final List<Question> questions;
  final String? errorMessage;

  QuestionState({
    this.isLoading = false,
    this.questions = const [],
    this.errorMessage,
  });

  QuestionState copyWith({
    bool? isLoading,
    List<Question>? questions,
    String? errorMessage,
  }) {
    return QuestionState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      errorMessage: errorMessage,
    );
  }
}

// Notifier to handle question generation logic
class QuestionNotifier extends StateNotifier<QuestionState> {
  final AiService _aiService;

  QuestionNotifier(this._aiService) : super(QuestionState());

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

  // Method to clear questions after a practice session is complete
  void clearQuestions() {
    state = QuestionState();
  }
}

final questionNotifierProvider =
    StateNotifierProvider<QuestionNotifier, QuestionState>((ref) {
      final aiService = ref.watch(aiServiceProvider);
      final trackingService = ref.watch(trackingServiceProvider); // New
      final authState = ref.watch(authNotifierProvider); // New

      return QuestionNotifier(aiService, trackingService, authState);
    });
