import 'package:flutter/material.dart';

SizedBox buildFormButton(
    {required void Function() onPressed, required String text}) {
  return SizedBox(
    width: double.maxFinite,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Colors.blue.withOpacity(0.5),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.purple,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}