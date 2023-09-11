import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/colors.dart';
class ContactEditRow extends StatelessWidget {
  const ContactEditRow({
    super.key,
    required this.icon,
    required this.mainText,
    required this.textType,
    this.onEditIconPressed,
  });

  final IconData icon;
  final String mainText;
  final String textType;
  final void Function()? onEditIconPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: color12, maxRadius: 25, child: Icon(icon) //icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: const TextStyle(
                fontSize: 15,
                color: color10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              textType,
              style: const TextStyle(
                color: color5,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onEditIconPressed,
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/svg/edit_Icon.svg',
              width: 28,
            ),
          ),
        ),
      ],
    );
  }
}