import '../models/event.dart';
import '../services/firebase_service.dart';

class EventRepository {
  final FirebaseService _firebaseService;

  EventRepository(this._firebaseService);

  Stream<List<Event>> watchActiveEvents() {
    return _firebaseService.watchActiveEvents();
  }

  Future<Event?> getEvent(String eventId) {
    return _firebaseService.getEvent(eventId);
  }

  Stream<Map<int, int>> watchEventVotes(String eventId) {
    return _firebaseService.watchEventVotes(eventId);
  }

  Future<void> submitVote({
    required String eventId,
    required String voterName,
    required List<int> selectedBoxes,
  }) async {
    try {
      if (voterName.isEmpty) {
        throw Exception('Vui lòng nhập tên');
      }

      if (selectedBoxes.length != 2) {
        throw Exception('Vui lòng chọn đủ 2 ô');
      }

      final isActive = await _firebaseService.isEventActive(eventId);
      if (!isActive) {
        throw Exception('Sự kiện không còn hoạt động');
      }

      final hasVoted = await _firebaseService.hasUserVoted(eventId, voterName);
      if (hasVoted) {
        throw Exception('Bạn đã bình chọn cho sự kiện này');
      }

      await _firebaseService.submitVote(
        eventId: eventId,
        voterName: voterName,
        selectedBoxes: selectedBoxes,
      );
    } catch (e) {
      throw Exception('Lỗi khi bình chọn: $e');
    }
  }

  Future<Map<String, dynamic>> getEventStatistics(String eventId) async {
    try {
      final votes = await _firebaseService.getEventVotes(eventId);
      final totalVotes = await _firebaseService.countEventVotes(eventId);

      Map<int, int> boxCounts = {};
      for (var vote in votes) {
        List<int> boxes = vote['selectedBoxes'];
        for (var box in boxes) {
          boxCounts[box] = (boxCounts[box] ?? 0) + 1;
        }
      }

      return {
        'totalVotes': totalVotes,
        'boxCounts': boxCounts,
        'votes': votes,
      };
    } catch (e) {
      throw Exception('Lỗi khi lấy thống kê: $e');
    }
  }

  Future<bool> hasUserVoted(String eventId, String voterName) {
    return _firebaseService.hasUserVoted(eventId, voterName);
  }
}