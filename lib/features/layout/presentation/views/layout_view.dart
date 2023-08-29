import 'package:ecommerce/core/widgets/enjoy_bar.dart';
import 'package:ecommerce/features/home/presentation/views/home_view.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:ecommerce/features/layout/presentation/managers/layout_cubit.dart';
import 'package:ecommerce/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../../../core/utils/colors.dart';
import '../../../profile/presentation/views/profile_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: color3,
        body: ListView(
          shrinkWrap: true,
          children: [
            cubit.screens[cubit.bottomNavCurrentIndex],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.bottomNavCurrentIndex,
          onTap: (value) {
            setState(() {
              cubit.onBottomNavIndexChange(index: value);
            });
          },
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'Card',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildDrawerElement({required void Function() onPressed}) {
    return ElevatedButton(
                onPressed:onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    color9,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person_outline, color: color2, size: 24),
                    SizedBox(
                      width: 22,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(color: color2, fontSize: 16),
                    ),
                  ],
                ),
              );
  }
}
