import 'package:flutter/material.dart';

class VoteBox extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const VoteBox({
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
          child: Center(
            child: Text(
              'Ô ${index + 1}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }
}