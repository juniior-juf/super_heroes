import 'package:flutter/material.dart';
import 'package:super_heroes/src/util/colors/colors_app.dart';

class ButtonNumberPagination extends StatelessWidget {
  final int number;
  final Function() onPressed;
  final bool isSelected;

  const ButtonNumberPagination({
    super.key,
    required this.number,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? ColorsApp.red : Colors.white,
          border: isSelected ? null : Border.all(color: ColorsApp.red),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : ColorsApp.red,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
