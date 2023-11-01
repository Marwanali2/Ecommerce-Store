import 'package:ecommerce/core/utils/colors.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });
  final IconData icon;
  final Color color;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        backgroundColor: const MaterialStatePropertyAll(color9),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
