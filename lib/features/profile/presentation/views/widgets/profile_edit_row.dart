import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../generated/l10n.dart';
class ProfileEditRow extends StatelessWidget {
  const ProfileEditRow({
    super.key,
    required this.type,
    required this.onPressed,
  });

  final String? type;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
           '$type',
          style: const TextStyle(fontSize: 17, color: color5),
        ),
        const Spacer(),
        TextButton(
          onPressed: onPressed, //  onPressed,
          child: Text(
            S.of(context).profileEdit,
            style: const TextStyle(
              color: color9,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}