import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/performance_provider.dart';
import '../parent/student_tracker_screen.dart'; // Reuse the PerformanceTile

class StudentPerformanceScreen extends ConsumerWidget {
  const StudentPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performanceState = ref.watch(performanceNotifierProvider);

    // Optional: Trigger fetch if coming from a different route
    // final notifier = ref.read(performanceNotifierProvider.notifier);
    // Future.microtask(() => notifier.fetchPerformances());

    if (performanceState.isLoading) {
      return const Scaffold(
        appBar: AppBar(title: Text('My Past Sessions')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Practice History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(performanceNotifierProvider.notifier)
                .fetchPerformances(),
          ),
        ],
      ),
      body: performanceState.performances.isEmpty
          ? const Center(
              child: Text('You haven\'t completed any practice sessions yet!'),
            )
          : ListView.builder(
              itemCount: performanceState.performances.length,
              itemBuilder: (context, index) {
                final p = performanceState.performances[index];
                // Reuse the visual component
                return PerformanceTile(performance: p);
              },
            ),
    );
  }
}
