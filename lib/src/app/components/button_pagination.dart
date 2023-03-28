import 'package:flutter/material.dart';
import 'package:super_heroes/src/util/colors/colors_app.dart';

class ButtonPagination extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const ButtonPagination(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 52,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: ColorsApp.red,
      ),
    );
  }
}
