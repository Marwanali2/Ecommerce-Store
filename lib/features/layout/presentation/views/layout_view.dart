import 'package:ecommerce/core/widgets/enjoy_bar.dart';
import 'package:ecommerce/features/layout/presentation/managers/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: Column(
          children: [
            EnjoyBar(context),
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
}
