import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';

SizedBox buildFormButton(
    {required BuildContext context,required void Function() onPressed, required String text}) {
  return SizedBox(
    width: double.maxFinite,
    height: MediaQuery.sizeOf(context).height*0.07,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        
        backgroundColor: MaterialStateProperty.all(
          color9,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ),
  );
}