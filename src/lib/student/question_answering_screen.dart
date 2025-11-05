import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/question_provider.dart';
import '../../models/question_model.dart';

class QuestionAnsweringScreen extends ConsumerWidget {
  const QuestionAnsweringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionNotifierProvider);
    final questions = questionState.questions;

    if (questions.isEmpty) {
      // Should not happen if navigation from PromptInputScreen is correct
      return const Scaffold(body: Center(child: Text("No questions loaded.")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(questionState.isGraded ? 'Results' : 'Practice Session'),
        actions: [
          if (!questionState.isGraded)
            TextButton(
              onPressed: () {
                ref.read(questionNotifierProvider.notifier).submitAnswers();
              },
              child: const Text(
                'Submit & Grade',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return QuestionCard(
            question: question,
            isGraded: questionState.isGraded,
            selectedAnswer: questionState.studentAnswers[question.id],
            onAnswerSelected: (answer) {
              ref
                  .read(questionNotifierProvider.notifier)
                  .recordAnswer(question.id, answer);
            },
          );
        },
      ),
      bottomNavigationBar: questionState.isGraded
          ? const ResultsSummaryBar()
          : null,
    );
  }
}

// --- Reusable Widget: QuestionCard ---
class QuestionCard extends StatelessWidget {
  final Question question;
  final String? selectedAnswer;
  final bool isGraded;
  final ValueChanged<String> onAnswerSelected;

  const QuestionCard({
    required this.question,
    required this.selectedAnswer,
    required this.isGraded,
    required this.onAnswerSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = isGraded && selectedAnswer == question.correctAnswer;
    final borderColor = isGraded
        ? (isCorrect ? Colors.green.shade700 : Colors.red.shade700)
        : Colors.grey.shade300;

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: isGraded ? 4 : 1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: isGraded ? 3 : 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q: ${question.text}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...question.options.map((option) {
              return RadioListTile<String>(
                title: Text(
                  option,
                  style: TextStyle(
                    fontWeight: isGraded && option == question.correctAnswer
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isGraded && option == question.correctAnswer
                        ? Colors.green.shade800
                        : Colors.black,
                  ),
                ),
                value: option,
                groupValue: selectedAnswer,
                onChanged: isGraded
                    ? null
                    : (value) => onAnswerSelected(value!),
                controlAffinity: ListTileControlAffinity.leading,
                // Highlight based on grading status
                tileColor: isGraded
                    ? (option == question.correctAnswer
                          ? Colors
                                .green
                                .shade50 // Correct answer highlight
                          : (option == selectedAnswer &&
                                    option != question.correctAnswer
                                ? Colors
                                      .red
                                      .shade50 // Wrong answer highlight
                                : null))
                    : null,
              );
            }).toList(),
            if (isGraded && !isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Your Answer: $selectedAnswer (Incorrect)',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (isGraded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Correct Answer: ${question.correctAnswer}',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- Reusable Widget: ResultsSummaryBar (Bottom Bar) ---
class ResultsSummaryBar extends ConsumerWidget {
  const ResultsSummaryBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionNotifierProvider);
    if (!state.isGraded) return const SizedBox.shrink();

    int correctCount = 0;
    for (var q in state.questions) {
      if (state.studentAnswers[q.id] == q.correctAnswer) {
        correctCount++;
      }
    }
    final totalCount = state.questions.length;
    final percentage = (correctCount / totalCount * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Session Graded!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Score: $correctCount / $totalCount ($percentage%)',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate back to the main student screen
              ref.read(questionNotifierProvider.notifier).clearQuestions();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.home),
            label: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
