import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/vote/vote_cubit.dart';
import '../../../cubits/vote/vote_state.dart';
class SubmitButton extends StatelessWidget {
  final String eventId;

  const SubmitButton({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoteCubit, VoteState>(
      buildWhen: (previous, current) =>
      previous.canSubmit != current.canSubmit ||
          previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: state.canSubmit
                ? () => context.read<VoteCubit>().submitVote(eventId)
                : null,
            child: Container(
              width: double.infinity,
              height: 48,
              child: Center(
                child: state.status == VoteStatus.submitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Bình chọn',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}