import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/enjoy_bar.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../managers/products_cubit/products_cubit.dart';
import 'banner_section.dart';
import 'categories_tap_products_section.dart';
import 'categories_taps_section.dart';
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  static bool isElectronicDevices = true;
  static bool isPreventCorona = false;
  static bool isSports = false;
  static bool isLighting = false;
  static bool isClothes = false;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    var bannersCubit = BlocProvider.of<BannerCubit>(context);
    var categoriesCubit = BlocProvider.of<CategoriesCubit>(context)..getCategoryProducts(categoryId: 44);
     var productsCubit = BlocProvider.of<ProductsCubit>(context);
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    var cartsCubit = BlocProvider.of<CartsCubit>(context);
    final pageController = PageController();
    TextEditingController textController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enjoyBar(context, text: 'Enjoy our products'),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SearchTextField(textController: textController, productsCubit: productsCubit, favoritesCubit: favoritesCubit, cartsCubit: cartsCubit)//buildSearchTextFormField(textController, productsCubit, context, favoritesCubit, cartsCubit),
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<BannerCubit, BannerState>(
          builder: (context, state) {
            if (state is BannerSuccess) {
              return BannerSection(pageController: pageController, bannersCubit: bannersCubit);
            } else if (state is BannerFailure) {
              return const SizedBox(height: 150, child: CustomErrorWidget());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child:Text(
            'Select Category',
            style: TextStyle(
              color: color4,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CategoriesTaps(categoriesCubit: categoriesCubit) //buildCategoriesNamesListView(categoriesCubit),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoryProductsSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: CategoryTapProductsListView(categoriesCubit: categoriesCubit, favoritesCubit: favoritesCubit, cartsCubit: cartsCubit)
              );
            } else if (state is CategoryProductsFailure) {
              return const Center(child: CustomErrorWidget());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}