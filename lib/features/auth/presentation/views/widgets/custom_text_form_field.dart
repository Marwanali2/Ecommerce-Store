import 'package:ecommerce/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({

    required this.label,
   required this.hintText,
     this.onChanged,
    required this.onFieldSubmitted,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.borderColor,
    required this.labelTextColor,
    required this.hintTextColor,
    required this.inputTextColor
  });

  String? label;
  String? hintText;
  Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  Color? enabledBorderColor;
  Color? focusedBorderColor;
  Color? borderColor;
  Color? inputTextColor;
  Color? labelTextColor;
  Color? hintTextColor;
  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (textEditingController.text.isEmpty) {
          return 'Required*';
        }
      },

      cursorColor: color9,
      style:  TextStyle(color: inputTextColor),
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor!),
            borderRadius: BorderRadius.circular(20)
        ),
        //
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor!),
            borderRadius: BorderRadius.circular(10)
        ),
        border:  OutlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(20)
        ),

        label: Text(
          "$label",
          style:  TextStyle(color: labelTextColor,),
        ),
        hintText: "$hintText",
        hintStyle:  TextStyle(color: hintTextColor,),
      ),
      //onChanged: onChanged,
      onFieldSubmitted:onFieldSubmitted ,
    );
  }
}
