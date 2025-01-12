import 'package:atomi_yep/repository/vote_repository.dart';
import 'package:atomi_yep/screens/voting/vote_grid.dart';
import 'package:atomi_yep/screens/voting/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/event.dart';
import '../../cubits/vote/vote_cubit.dart';
import '../../cubits/vote/vote_state.dart';
import 'name_input.dart';

class VotingScreen extends StatelessWidget {
  final Event event;

  const VotingScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VoteCubit(context.read<VoteRepository>()),
      child: BlocListener<VoteCubit, VoteState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {
          if (state.status == VoteStatus.success) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bình chọn thành công!')),
            );
          }
          if (state.status == VoteStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Có lỗi xảy ra')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(event.name),
            centerTitle: true,
          ),
          body: Column(
            children: [
              NameInput(),
              Expanded(child: VoteGrid()),
              SubmitButton(eventId: event.id),
            ],
          ),
        ),
      ),
    );
  }
}