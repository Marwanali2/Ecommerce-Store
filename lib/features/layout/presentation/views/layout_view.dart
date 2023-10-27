import 'package:ecommerce/features/layout/presentation/managers/layout_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/views/register_view.dart';
import '../../../card/presentation/managers/carts_cubit.dart';
import '../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../../home/presentation/managers/banner_cubit/banner_cubit.dart';
import '../../../home/presentation/managers/categories_cubit/categories_cubit.dart';
import '../../../home/presentation/managers/products_cubit/products_cubit.dart';
import '../../../layout/presentation/managers/layout_cubit.dart';
import '../../../layout/presentation/views/layout_view.dart';
import '../../../profile/presentation/managers/user_data_cubit.dart';
import '../../../profile/presentation/views/profile_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {

  @override
  void initState(){
    super.initState();
    BlocProvider(create: (context) => LayoutCubit(),);
    BlocProvider(create: (context) => BannerCubit()..getBanners(),);
    BlocProvider(create: (context) => CategoriesCubit());
    BlocProvider(create: (context) => ProductsCubit()..getProducts(),);
    BlocProvider(create: (context) => FavoritesCubit()..getFavorites(),);
    BlocProvider(create: (context) => CartsCubit()..getCarts(),);
    BlocProvider( create: (context) => UserDataCubit()..getUserData(),);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:color3,//color3,
        body: SingleChildScrollView(
          // shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          child:  cubit.screens[cubit.bottomNavCurrentIndex],
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
          items:  [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: S.of(context).bottomNavHome,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.category_outlined,
            //   ),
            //   label: 'Categories',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              label: S.of(context).bottomNavFav,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: S.of(context).bottomNavCard,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings',
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
