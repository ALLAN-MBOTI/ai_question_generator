import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/question_provider.dart';
import '../../providers/auth_provider.dart'; // Import Auth Provider
import 'question_answering_screen.dart';
import 'student_performance_screen.dart'; // Import new screen

class PromptInputScreen extends ConsumerStatefulWidget {
  const PromptInputScreen({super.key});

  @override
  ConsumerState<PromptInputScreen> createState() => _PromptInputScreenState();
}

class _PromptInputScreenState extends ConsumerState<PromptInputScreen> {
  final _promptController = TextEditingController(
    text: 'The water cycle in 5th-grade science',
  );
  int _questionCount = 5;

  void _generate() async {
    if (_promptController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic prompt.')),
      );
      return;
    }

    // Call the generation logic
    final notifier = ref.read(questionNotifierProvider.notifier);
    await notifier.generateQuestions(
      _promptController.text.trim(),
      _questionCount,
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(questionNotifierProvider);

    // Listen for successful generation to navigate
    ref.listen<QuestionState>(questionNotifierProvider, (previous, current) {
      if (!current.isLoading && current.questions.isNotEmpty) {
        // Navigate to the next screen upon successful generation
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const QuestionAnsweringScreen(),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('New Practice Session')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text(
                'Student Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('New Practice Session'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Already on this screen, no action needed, or ensure questions are cleared.
                ref.read(questionNotifierProvider.notifier).clearQuestions();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('My Practice History'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the performance screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StudentPerformanceScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                // Call the signOut method from AuthNotifier
                ref.read(authNotifierProvider.notifier).signOut();
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'What topic do you want to practice?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _promptController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText:
                    'E.g., "Molar mass calculations for high school chemistry"',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Question Count Selector
            ListTile(
              title: const Text('Number of Questions'),
              trailing: DropdownButton<int>(
                value: _questionCount,
                items: [5, 10, 15, 20]
                    .map(
                      (count) =>
                          DropdownMenuItem(value: count, child: Text('$count')),
                    )
                    .toList(),
                onChanged: state.isLoading
                    ? null
                    : (value) => setState(() => _questionCount = value!),
              ),
            ),
            const Spacer(),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _generate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Generate Questions',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            // Display error message if any
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
