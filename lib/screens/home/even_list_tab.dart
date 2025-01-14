import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/event/event_cubit.dart';
import '../../cubits/event/event_state.dart';
import '../event_card/event_card_screen.dart';

class EventListTab extends StatelessWidget {
  final String status;

  const EventListTab({required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        if (state.status == EventStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredEvents = state.events.where((e) => e.status == status).toList();

        if (filteredEvents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  _getEmptyMessage(status),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            return EventCard(event: filteredEvents[index]);
          },
        );
      },
    );
  }

  String _getEmptyMessage(String status) {
    switch (status) {
      case 'active':
        return 'Không có sự kiện nào đang diễn ra';
      case 'pending':
        return 'Không có sự kiện nào sắp diễn ra';
      case 'closed':
        return 'Không có sự kiện nào đã kết thúc';
      default:
        return 'Không có sự kiện nào';
    }
  }
}