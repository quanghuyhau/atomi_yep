import 'package:atomi_yep/constant/app_color.dart';
import 'package:atomi_yep/constant/imageconstant.dart';
import 'package:atomi_yep/models/choice.dart';
import 'package:atomi_yep/screens/voting/widget/vote_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/vote/vote_cubit.dart';
import '../../../cubits/vote/vote_state.dart';

class VoteGrid extends StatelessWidget {
  final List<ChoiceModel> choices;

  const VoteGrid({required this.choices});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoteCubit, VoteState>(
      buildWhen: (previous, current) =>
          previous.selectedBoxes != current.selectedBoxes,
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          itemCount: choices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            final choice = choices[index];
            final isSelected = state.selectedBoxes.contains(index);
            return GestureDetector(
              onTap: () => context.read<VoteCubit>().toggleBox(index),

              child: _itemChoice(choice: choice, isSelect: isSelected),
              // child: Padding(
              //   padding: EdgeInsets.all(8),
              //   child: Row(
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(8),
              //         child: Image.asset(
              //           choice.imagePath,
              //           width: 60,
              //           height: 60,
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //       SizedBox(width: 16),
              //       Expanded(
              //         child: Text(
              //           choice.textChoice,
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w500,
              //             color: isSelected
              //                 ? Theme.of(context).primaryColor
              //                 : Colors.black87,
              //           ),
              //         ),
              //       ),
              //       if (isSelected)
              //         Container(
              //           padding: EdgeInsets.all(8),
              //           decoration: BoxDecoration(
              //             color: Theme.of(context).primaryColor.withOpacity(0.1),
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.check,
              //             color: Theme.of(context).primaryColor,
              //             size: 20,
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
            );
          },
        );
      },
    );
  }

  Widget _itemChoice({required ChoiceModel choice, required bool isSelect}) {
    return Container(
      height: 200,
      width: 120,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelect ? null : AppColors.white,
        gradient: isSelect ? GradientUtils.primaryGradient : null,
        // boxShadow: [
        //   BoxShadow(
        //     color: isSelect ?  AppColors.white : AppColors.black.withOpacity(0.2),
        //     blurRadius: 2,
        //     offset: const  Offset(2, 2),
        //     spreadRadius: 0.2,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            child: Image.asset(
              choice.imagePath,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                choice.textChoice,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelect ? AppColors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
