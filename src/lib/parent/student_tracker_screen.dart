import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/performance_provider.dart';
import '../../models/performance_model.dart';
import '../../providers/auth_provider.dart';

class StudentTrackerScreen extends ConsumerWidget {
  const StudentTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performanceState = ref.watch(performanceNotifierProvider);

    if (performanceState.isLoading) {
      return const Scaffold(
        appBar: AppBar(title: Text('Student Tracker')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (performanceState.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Student Tracker')),
        body: Center(child: Text(performanceState.errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Performance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(performanceNotifierProvider.notifier)
                .fetchPerformances(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: performanceState.performances.isEmpty
          ? const Center(
              child: Text(
                'No performance data found for your linked students.',
              ),
            )
          : ListView.builder(
              itemCount: performanceState.performances.length,
              itemBuilder: (context, index) {
                final p = performanceState.performances[index];
                return PerformanceTile(performance: p);
              },
            ),
    );
  }
}

class PerformanceTile extends StatelessWidget {
  final Performance performance;
  const PerformanceTile({required this.performance, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${performance.percentage.toStringAsFixed(0)}%'),
        backgroundColor: performance.percentage >= 70
            ? Colors.green
            : Colors.red,
        foregroundColor: Colors.white,
      ),
      title: Text(
        performance.topic,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${performance.studentName} | ${performance.date.toLocal().toString().split(' ')[0]}',
      ),
      trailing: Text('${performance.score}/${performance.totalQuestions}'),
      onTap: () {
        // Detailed view of the session
      },
    );
  }
}
