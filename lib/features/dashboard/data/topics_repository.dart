import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/models/topic_model.dart';

class TopicsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all topics ordered by order field
  Future<List<TopicModel>> getAllTopics() async {
    try {
      final querySnapshot = await _firestore
          .collection('topics')
          .orderBy('order')
          .get();

      return querySnapshot.docs
          .map((doc) => TopicModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch topics: $e');
    }
  }

  // Complete a topic and update user score
  Future<void> completeTopic(String userId, int pointsToAdd) async {
    try {
      await _firestore.runTransaction((transaction) async {
        // Get user document reference
        final userRef = _firestore.collection('users').doc(userId);
        
        // Get current user data
        final userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          throw Exception('User not found');
        }

        final currentScore = userDoc.data()?['score'] ?? 0;
        final newScore = currentScore + pointsToAdd;

        // Update user score
        transaction.update(userRef, {
          'score': newScore,
          'lastActive': FieldValue.serverTimestamp(),
        });

        // Create a record of topic completion
        final completionRef = _firestore
            .collection('UserTopicProgress')
            .doc('${userId}_${DateTime.now().millisecondsSinceEpoch}');
        
        transaction.set(completionRef, {
          'userId': userId,
          'completedAt': FieldValue.serverTimestamp(),
          'pointsEarned': pointsToAdd,
        });
      });
    } catch (e) {
      throw Exception('Failed to complete topic: $e');
    }
  }
} 