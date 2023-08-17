import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
   CustomTextField({this.label, this.hintText,this.onChanged,this.color});
   String?label;
   String?hintText;
   Function(String)?onChanged;
   Color?color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty){
          return 'Required*';
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color!),),//
         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color!),),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow),),

        label: Text(
          "$label",
          style: TextStyle(color: Colors.white),
        ),
        hintText: "$hintText",
        hintStyle: TextStyle(color: Colors.white),
      ),
      onChanged:onChanged ,
    );
  }
}
