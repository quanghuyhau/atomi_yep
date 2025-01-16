import 'package:atomi_yep/constant/app_color.dart';
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
        final buttonColor = state.canSubmit ? Color(0xFF25449C) : Colors.grey;
        final textColor = state.canSubmit ? Colors.white : Colors.grey;

        final gradientSubmit = state.canSubmit
            ? GradientUtils.primaryGradient
            : GradientUtils.offGradient;

        return InkWell(
          onTap: state.canSubmit
              ? () => context.read<VoteCubit>().submitVote(eventId)
              : null,
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: buttonColor,
          // ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: gradientSubmit),
            width: double.infinity,
            height: 48,
            child: Center(
              child: state.status == VoteStatus.submitting
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Bình chọn',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
