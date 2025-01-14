import '../services/firebase_service.dart';

class VoteRepository {
  final FirebaseService _firebaseService;

  VoteRepository(this._firebaseService);

  Future<void> submitVote({
    required String eventId,
    required String voterName,
    required List<int> selectedBoxes,
  }) async {
    try {
      final isActive = await _firebaseService.isEventActive(eventId);
      if (!isActive) {
        throw Exception('Sự kiện không còn hoạt động');
      }

      final hasVoted = await _firebaseService.hasUserVoted(eventId, voterName);
      if (hasVoted) {
        throw Exception('Bạn đã bình chọn cho sự kiện này');
      }

      if (selectedBoxes.length != 2) {
        throw Exception('Vui lòng chọn đủ 2 ô');
      }

      if (selectedBoxes.any((box) => box < 0 || box > 7)) {
        throw Exception('Ô được chọn không hợp lệ');
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

  Future<Map<int, int>> getVoteResults(String eventId) async {
    try {
      final votes = await _firebaseService.getEventVotes(eventId);

      Map<int, int> results = {};
      for (var vote in votes) {
        List<int> boxes = List<int>.from(vote['selectedBoxes']);
        for (var box in boxes) {
          results[box] = (results[box] ?? 0) + 1;
        }
      }

      return results;
    } catch (e) {
      throw Exception('Lỗi khi lấy kết quả: $e');
    }
  }

  Future<bool> hasUserVoted(String eventId, String voterName) {
    return _firebaseService.hasUserVoted(eventId, voterName);
  }

  Stream<Map<int, int>> watchVoteResults(String eventId) {
    return _firebaseService.watchEventVotes(eventId);
  }

  Future<int?> getTotalVotes(String eventId) {
    return _firebaseService.countEventVotes(eventId);
  }
}