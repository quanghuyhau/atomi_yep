import 'package:atomi_yep/cubits/event/event_cubit.dart';
import 'package:atomi_yep/cubits/event/event_state.dart';
import 'package:atomi_yep/models/event.dart';
import 'package:atomi_yep/screens/event_card/event_card_screen.dart';
import 'package:atomi_yep/screens/voting/voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sự Kiện Đang Diễn Ra'),
        centerTitle: true,
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state.status == EventStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.events.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Chưa có sự kiện nào đang diễn ra',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              final event = state.events[index];
              return EventCard(event: event);
            },
          );
        },
      ),
    );
  }
}

