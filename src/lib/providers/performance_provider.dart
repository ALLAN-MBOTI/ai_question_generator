import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/performance_model.dart';
import '../services/tracking_service.dart';
import 'auth_provider.dart';

class PerformanceState {
  final List<Performance> performances;
  final bool isLoading;
  final String? errorMessage;

  PerformanceState({
    this.performances = const [],
    this.isLoading = true,
    this.errorMessage,
  });

  PerformanceState copyWith({
    List<Performance>? performances,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PerformanceState(
      performances: performances ?? this.performances,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class PerformanceNotifier extends StateNotifier<PerformanceState> {
  final TrackingService _trackingService;
  final AuthState _authState;

  PerformanceNotifier(this._trackingService, this._authState)
    : super(PerformanceState()) {
    if (_authState.isAuthenticated) {
      fetchPerformances();
    }
  }

  Future<void> fetchPerformances() async {
    final user = _authState.user;
    if (user == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'User not authenticated.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final results = await _trackingService.getPerformances(
        userRole: user.role,
        userId: user.id,
      );
      state = state.copyWith(isLoading: false, performances: results);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final performanceNotifierProvider =
    StateNotifierProvider<PerformanceNotifier, PerformanceState>((ref) {
      final trackingService = ref.watch(trackingServiceProvider);
      final authState = ref.watch(authNotifierProvider);
      return PerformanceNotifier(trackingService, authState);
    });
