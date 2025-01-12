import 'package:equatable/equatable.dart';
import '../../models/event.dart';

enum EventStatus { initial, loading, success, failure }

class EventState extends Equatable {
  final List<Event> events;
  final EventStatus status;
  final String? error;

  const EventState({
    this.events = const [],
    this.status = EventStatus.initial,
    this.error,
  });

  EventState copyWith({
    List<Event>? events,
    EventStatus? status,
    String? error,
  }) {
    return EventState(
      events: events ?? this.events,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [events, status, error];
}