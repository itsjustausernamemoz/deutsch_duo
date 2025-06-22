import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final int score;
  final String? fcmToken;
  final DateTime? lastActive;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.score,
    this.fcmToken,
    this.lastActive,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      score: data['score'] ?? 0,
      fcmToken: data['fcmToken'],
      lastActive: data['lastActive'] != null 
          ? (data['lastActive'] as Timestamp).toDate() 
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'score': score,
      'fcmToken': fcmToken,
      'lastActive': lastActive != null ? Timestamp.fromDate(lastActive!) : null,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? score,
    String? fcmToken,
    DateTime? lastActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      score: score ?? this.score,
      fcmToken: fcmToken ?? this.fcmToken,
      lastActive: lastActive ?? this.lastActive,
    );
  }
} 