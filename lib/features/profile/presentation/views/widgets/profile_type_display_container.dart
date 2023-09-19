import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
class ProfileTypesDisplayContainer extends StatelessWidget {
  const ProfileTypesDisplayContainer({
    super.key,
    required this.typeValue,
  });

  final String? typeValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 60,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width,
      ),
      decoration: BoxDecoration(
        color: color5.withOpacity(
          0.2,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          '$typeValue',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}