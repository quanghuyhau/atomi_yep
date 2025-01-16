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
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
          itemCount: choices.length,
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85

        ),
          // separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final choice = choices[index];
            final isSelected = state.selectedBoxes.contains(index);
            return InkWell(
              onTap: () => context.read<VoteCubit>().toggleBox(index),
              borderRadius: BorderRadius.circular(12),
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

  Widget _itemChoice({required ChoiceModel choice, required bool isSelect}){
    return Container(
      height: 200,
      width: 120,
      margin: EdgeInsets.all(8),
      padding: const  EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelect ? null : AppColors.white ,
        gradient: isSelect ? GradientUtils.primaryGradient : null,
        boxShadow: [
          BoxShadow(
            color: isSelect ?  AppColors.white : AppColors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const  Offset(2, 2),
            spreadRadius: 0.2,
          ),
        ],

      ),
      child: Column(
        children: [
          Image.asset(
            choice.imagePath,
          ),
          Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                choice.textChoice,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelect
                      ? AppColors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}