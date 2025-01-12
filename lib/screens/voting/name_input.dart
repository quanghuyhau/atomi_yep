import 'package:atomi_yep/cubits/vote/vote_cubit.dart';
import 'package:atomi_yep/cubits/vote/vote_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              context.read<VoteCubit>().updateVoterName(value);
            },
            decoration: InputDecoration(
              labelText: 'Tên của bạn',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 8),
          BlocBuilder<VoteCubit, VoteState>(
            buildWhen: (previous, current) =>
            previous.selectedBoxes.length != current.selectedBoxes.length,
            builder: (context, state) {
              return Text(
                'Chọn 2 ô để bình chọn (${state.selectedBoxes.length}/2)',
                style: TextStyle(color: Colors.grey[600]),
              );
            },
          ),
        ],
      ),
    );
  }
}