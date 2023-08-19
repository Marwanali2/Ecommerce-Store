import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/two_texts_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'banners_list_view.dart';
import 'categories_list_view.dart';
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bannersCubit = BlocProvider.of<BannerCubit>(context);
        var categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
        var productsCubit = BlocProvider.of<ProductsCubit>(context);
        final pageController = PageController();
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              searchField(),
              const SizedBox(
                height: 15,
              ),
              bannersCubit.bannersList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : bannersListView(pageController, bannersCubit),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: bannersCubit.bannersList.length,
                  axisDirection: Axis.horizontal,
                  effect: const ScrollingDotsEffect(
                    radius: 5,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: twoTextsRow(fText: 'Categories', sText: 'View All'),
              ),
              const SizedBox(
                height: 15,
              ),
              categoriesCubit.categoriesList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : categoriesListView(context, categoriesCubit),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: twoTextsRow(fText: 'Products', sText: 'View All'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SizedBox(
                  height: 500,
                  child: productsCubit.productsModelList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : productsGridView(productsCubit),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}