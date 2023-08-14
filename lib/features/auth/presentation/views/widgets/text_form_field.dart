import 'package:flutter/material.dart';

TextFormField buildTextFormField(
    {required String label,
      required IconData prefixIcon,
      required TextEditingController controller,
      required TextInputType keyboardType}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: (value) {
      if (controller.text.isEmpty) {
        return 'Please Enter $label';
      }
      return null;
    },
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
      ),
      enabled: true,
      label: Text(
        label,
        style: TextStyle(fontSize: 20,),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ), // shape of border when validator is empty
    ),
  );
}


