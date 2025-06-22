import 'package:cloud_firestore/cloud_firestore.dart';

class TopicModel {
  final String id;
  final String title;
  final int level;
  final int order;
  final int pointsValue;
  final String? description;

  TopicModel({
    required this.id,
    required this.title,
    required this.level,
    required this.order,
    required this.pointsValue,
    this.description,
  });

  factory TopicModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TopicModel(
      id: doc.id,
      title: data['title'] ?? '',
      level: data['level'] ?? 1,
      order: data['order'] ?? 0,
      pointsValue: data['pointsValue'] ?? 10,
      description: data['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'level': level,
      'order': order,
      'pointsValue': pointsValue,
      'description': description,
    };
  }

  TopicModel copyWith({
    String? id,
    String? title,
    int? level,
    int? order,
    int? pointsValue,
    String? description,
  }) {
    return TopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      level: level ?? this.level,
      order: order ?? this.order,
      pointsValue: pointsValue ?? this.pointsValue,
      description: description ?? this.description,
    );
  }
} 