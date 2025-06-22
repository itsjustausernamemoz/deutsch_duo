import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/topics_repository.dart';
import '../../../shared/models/topic_model.dart';

// Repository provider
final topicsRepositoryProvider = Provider<TopicsRepository>((ref) {
  return TopicsRepository();
});

// Topics list provider
final topicsProvider = FutureProvider<List<TopicModel>>((ref) async {
  final repository = ref.watch(topicsRepositoryProvider);
  return await repository.getAllTopics();
});

// Topic completion notifier
class TopicCompletionNotifier extends StateNotifier<AsyncValue<void>> {
  final TopicsRepository _repository;

  TopicCompletionNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> completeTopic(String userId, int pointsToAdd) async {
    state = const AsyncValue.loading();
    try {
      await _repository.completeTopic(userId, pointsToAdd);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final topicCompletionProvider = StateNotifierProvider<TopicCompletionNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(topicsRepositoryProvider);
  return TopicCompletionNotifier(repository);
}); 