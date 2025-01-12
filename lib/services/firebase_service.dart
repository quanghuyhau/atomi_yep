import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Event>> watchActiveEvents() {
    return _firestore
        .collection('events')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Event.fromFirestore(doc))
        .toList());
  }

  Future<Event?> getEvent(String eventId) async {
    final doc = await _firestore.collection('events').doc(eventId).get();
    if (doc.exists) {
      return Event.fromFirestore(doc);
    }
    return null;
  }

  Future<void> submitVote({
    required String eventId,
    required String voterName,
    required List<int> selectedBoxes,
  }) async {
    try {
      final eventDoc = await _firestore
          .collection('events')
          .doc(eventId)
          .get();

      if (!eventDoc.exists) {
        throw Exception('Sự kiện không tồn tại');
      }

      if (eventDoc.data()?['status'] != 'active') {
        throw Exception('Sự kiện không còn hoạt động');
      }

      final existingVote = await _firestore
          .collection('events')
          .doc(eventId)
          .collection('votes')
          .where('voterName', isEqualTo: voterName)
          .get();

      if (existingVote.docs.isNotEmpty) {
        throw Exception('Bạn đã bình chọn cho sự kiện này');
      }

      if (selectedBoxes.length != 2) {
        throw Exception('Vui lòng chọn đủ 2 ô');
      }

      if (selectedBoxes.any((box) => box < 0 || box > 7)) {
        throw Exception('Ô được chọn không hợp lệ');
      }

      await _firestore
          .collection('events')
          .doc(eventId)
          .collection('votes')
          .add({
        'voterName': voterName,
        'selectedBoxes': selectedBoxes,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (e is FirebaseException) {
        throw Exception('Lỗi kết nối: ${e.message}');
      }
      throw Exception('Lỗi khi bình chọn: $e');
    }
  }

  Stream<Map<int, int>> watchEventVotes(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('votes')
        .snapshots()
        .map((snapshot) {
      Map<int, int> boxVotes = {};
      for (var doc in snapshot.docs) {
        List<int> selectedBoxes =
        List<int>.from(doc.data()['selectedBoxes'] ?? []);
        for (var boxIndex in selectedBoxes) {
          boxVotes[boxIndex] = (boxVotes[boxIndex] ?? 0) + 1;
        }
      }
      return boxVotes;
    });
  }

  Future<List<Map<String, dynamic>>> getEventVotes(String eventId) async {
    final snapshot = await _firestore
        .collection('events')
        .doc(eventId)
        .collection('votes')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => {
      'id': doc.id,
      'voterName': doc.data()['voterName'] as String,
      'selectedBoxes': List<int>.from(doc.data()['selectedBoxes'] ?? []),
      'timestamp': (doc.data()['timestamp'] as Timestamp).toDate(),
    })
        .toList();
  }

  Future<bool> isEventActive(String eventId) async {
    final doc = await _firestore.collection('events').doc(eventId).get();
    return doc.exists && doc.data()?['status'] == 'active';
  }

  Future<int?> countEventVotes(String eventId) async {
    final snapshot = await _firestore
        .collection('events')
        .doc(eventId)
        .collection('votes')
        .count()
        .get();

    return snapshot.count;
  }

  Future<bool> hasUserVoted(String eventId, String voterName) async {
    final snapshot = await _firestore
        .collection('events')
        .doc(eventId)
        .collection('votes')
        .where('voterName', isEqualTo: voterName)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}