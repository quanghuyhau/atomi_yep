import 'package:atomi_yep/screens/voting/widget/vote_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/vote/vote_cubit.dart';
import '../../../cubits/vote/vote_state.dart';

class VoteGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoteCubit, VoteState>(
      buildWhen: (previous, current) =>
      previous.selectedBoxes != current.selectedBoxes,
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            final isSelected = state.selectedBoxes.contains(index);
            return VoteBox(
              index: index,
              isSelected: isSelected,
              onTap: () => context.read<VoteCubit>().toggleBox(index),
            );
          },
        );
      },
    );
  }
}