import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../managers/categories_cubit/categories_cubit.dart';
import 'home_view_body.dart';
class CategoriesTaps extends StatefulWidget {
  const CategoriesTaps({Key? key, required this.categoriesCubit,}) : super(key: key);
  final CategoriesCubit categoriesCubit;


  @override
  State<CategoriesTaps> createState() => _CategoriesTapsState();
}

class _CategoriesTapsState extends State<CategoriesTaps> {
  @override
  Widget build(BuildContext context) {
    SizedBox buildCategoriesRowItem({required String categoryName, required void Function() onPressed, required bool categoryBooleanName}) {
      return SizedBox(
        width: 180,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            backgroundColor: categoryBooleanName
                ? MaterialStateProperty.all(color9)
                : MaterialStateProperty.all(Colors.white),
          ),
          child: Text(
            categoryName,
            style: TextStyle(
              color: categoryBooleanName ? Colors.white : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          List<String> categoriesNames = [
            S.of(context).catTap1,
            S.of(context).catTap2,
            S.of(context).catTap3,
            S.of(context).catTap4,
            S.of(context).catTap5,
          ];
          List<bool> categoriesBooleanNames = [
            HomeViewBody.isElectronicDevices,
            HomeViewBody.isPreventCorona,
            HomeViewBody.isSports,
            HomeViewBody.isLighting,
            HomeViewBody.isClothes,
          ];
          List<void Function()> categoriesOnPressed = [
                () async {
              setState(() {
                HomeViewBody.isElectronicDevices = true;
                HomeViewBody.isPreventCorona = false;
                HomeViewBody.isSports = false;
                HomeViewBody.isLighting = false;
                HomeViewBody.isClothes = false;
              });
              await widget.categoriesCubit.getCategoryProducts(categoryId: 44);
            },
                () async {
              setState(() {
                HomeViewBody.isElectronicDevices = false;
                HomeViewBody.isPreventCorona = true;
                HomeViewBody.isSports = false;
                HomeViewBody.isLighting = false;
                HomeViewBody.isClothes = false;
              });
              await widget.categoriesCubit.getCategoryProducts(categoryId: 43);
            },
                () async {
              setState(() {
                HomeViewBody.isElectronicDevices = false;
                HomeViewBody.isPreventCorona = false;
                HomeViewBody.isSports = true;
                HomeViewBody.isLighting = false;
                HomeViewBody.isClothes = false;
              });
              await widget.categoriesCubit.getCategoryProducts(categoryId: 42);
            },
                () async {
              setState(() {
                HomeViewBody.isElectronicDevices = false;
                HomeViewBody.isPreventCorona = false;
                HomeViewBody.isSports = false;
                HomeViewBody.isLighting = true;
                HomeViewBody.isClothes = false;
              });
              await widget.categoriesCubit.getCategoryProducts(categoryId: 40);
            },
                () async {
              setState(() {
                HomeViewBody.isElectronicDevices = false;
                HomeViewBody.isPreventCorona = false;
                HomeViewBody.isSports = false;
                HomeViewBody.isLighting = false;
                HomeViewBody.isClothes = true;
              });
              await widget.categoriesCubit.getCategoryProducts(categoryId: 46);
            },
          ];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildCategoriesRowItem(
              categoryName: categoriesNames[index],
              categoryBooleanName: categoriesBooleanNames[index],
              onPressed: categoriesOnPressed[index],
            ),

          );
        },
      ),
    );
  }
}