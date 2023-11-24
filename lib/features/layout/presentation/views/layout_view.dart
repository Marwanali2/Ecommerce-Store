import 'package:animate_do/animate_do.dart';
import 'package:ecommerce/core/utils/app_router.dart';
import 'package:ecommerce/features/auth/presentation/managers/auth_cubit.dart';
import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/layout/presentation/managers/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../../core/utils/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../card/presentation/managers/carts_cubit.dart';
import '../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../../home/presentation/managers/banner_cubit/banner_cubit.dart';
import '../../../home/presentation/managers/categories_cubit/categories_cubit.dart';
import '../../../home/presentation/managers/products_cubit/products_cubit.dart';
import '../../../profile/presentation/managers/user_data_cubit.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  void initState() {
    super.initState();

    BlocProvider(create: (context) => AuthCubit());
    BlocProvider(
      create: (context) => LayoutCubit(),
    );
    BlocProvider(
      create: (context) => BannerCubit()..getBanners(),
    );
    BlocProvider(create: (context) => CategoriesCubit()..getCategories());
    BlocProvider(
      create: (context) => ProductsCubit()..getProducts(),
    );
    BlocProvider(
      create: (context) => FavoritesCubit()..getFavorites(),
    );
    BlocProvider(
      create: (context) => CartsCubit()..getCarts(),
    );
    BlocProvider(
      create: (context) => UserDataCubit()..getUserData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              extendBody: true,
              backgroundColor: color3, //color3,
              body: FadeInUp(
                animate: true,
                child: SingleChildScrollView(
                  // shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  child: cubit.screens[cubit.bottomNavCurrentIndex],
                ),
              ),
              bottomNavigationBar: StylishBottomBar(
                option: AnimatedBarOptions(
                  opacity: 0.3,
                  inkColor: color9,
                  inkEffect: true,
                ),
                items: [
                  BottomBarItem(
                    selectedColor: color9,
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    title: Text(S.of(context).bottomNavHome),
                  ),
                  BottomBarItem(
                    selectedColor: color9,
                    icon: const Icon(
                      Icons.favorite_outline,
                    ),
                    title: Text(S.of(context).bottomNavFav),
                  ),
                  BottomBarItem(
                    selectedColor: color9,
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    title: Text(S.of(context).bottomNavCard),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  10,
                ),
                hasNotch: true,
                currentIndex: cubit.bottomNavCurrentIndex,
                onTap: (value) {
                  setState(() {
                    cubit.onBottomNavIndexChange(index: value);
                  });
                },
              )),
        );
      },
    );
  }
/* 
  ElevatedButton buildDrawerElement({required void Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
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
*/
}

/*BottomNavigationBar(
          currentIndex: cubit.bottomNavCurrentIndex,
          onTap: (value) {
            setState(() {
              cubit.onBottomNavIndexChange(index: value);
            });
          },
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home_outlined,
              ),
              label: S.of(context).bottomNavHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.favorite_outline,
              ),
              label: S.of(context).bottomNavFav,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
              label: S.of(context).bottomNavCard,
            ),
          ],
        ), */
