import 'package:atomi_yep/models/choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final String status;
  final DateTime createdAt;
  final List<ChoiceModel> listChoice;

  Event({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    this.listChoice = const [],
  });

  Event copyWith({
    String? id,
    String? name,
    String? status,
    DateTime? createdAt,
    List<ChoiceModel>? listChoice,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      listChoice: listChoice ?? this.listChoice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'boxNames': listChoice.map((e) => e.toMap()).toList(),
    };
  }

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    List<ChoiceModel> choiceList = [];
    if (data['boxNames'] != null && data['boxNames'] is List) {
      choiceList = (data['boxNames'] as List)
          .map((choiceData) => ChoiceModel.fromMap(choiceData))
          .toList();
    }

    return Event(
      id: doc.id,
      name: data['name'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      listChoice: choiceList,
    );
  }
}