import 'package:atomi_yep/models/choice.dart';
import 'package:flutter/material.dart';

class VoteBox extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final ChoiceModel choice;

  const VoteBox({
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.choice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : null,
            border: isSelected
                ? Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  choice.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    choice.textChoice,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}