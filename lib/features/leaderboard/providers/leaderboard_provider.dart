import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/leaderboard_repository.dart';
import '../../../shared/models/user_model.dart';

// Repository provider
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

// Leaderboard stream provider
final leaderboardProvider = StreamProvider<List<UserModel>>((ref) {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return repository.getLeaderboard();
}); 