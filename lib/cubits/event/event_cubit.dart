import 'package:atomi_yep/repository/event_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository _eventRepository;

  EventCubit(this._eventRepository) : super(EventState()) {
    _watchActiveEvents();
  }

  void _watchActiveEvents() {
    emit(state.copyWith(status: EventStatus.loading));

    _eventRepository.watchActiveEvents().listen(
          (events) {
        emit(state.copyWith(
          events: events,
          status: EventStatus.success,
        ));
      },
      onError: (error) {
        emit(state.copyWith(
          error: error.toString(),
          status: EventStatus.failure,
        ));
      },
    );
  }

  Future<void> submitVote({
    required String eventId,
    required String voterName,
    required List<int> selectedBoxes,
  }) async {
    try {
      await _eventRepository.submitVote(
        eventId: eventId,
        voterName: voterName,
        selectedBoxes: selectedBoxes,
      );
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        status: EventStatus.failure,
      ));
      rethrow;
    }
  }

  Stream<Map<int, int>> watchEventVotes(String eventId) {
    return _eventRepository.watchEventVotes(eventId);
  }

  Future<bool> hasUserVoted(String eventId, String voterName) {
    return _eventRepository.hasUserVoted(eventId, voterName);
  }
}