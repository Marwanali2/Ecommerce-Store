import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Padding searchField({required ProductsCubit cubit}) {
  String inputTextFromUser;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: TextFormField(
      onChanged: (value) {
       inputTextFromUser=value;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[350],
        contentPadding: EdgeInsets.zero,
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.black45),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            color: Colors.black45,
          ),
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.black45,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
      ),
    ),
  );
}
