import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/two_texts_row.dart';
import 'package:ecommerce/features/layout/presentation/managers/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/enjoy_bar.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../../data/models/products_model.dart';
import 'banners_list_view.dart';
import 'categories_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    var bannersCubit = BlocProvider.of<BannerCubit>(context);
    var categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    var productsCubit = BlocProvider.of<ProductsCubit>(context);
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    var cartsCubit = BlocProvider.of<CartsCubit>(context);
    final pageController = PageController();

    return SingleChildScrollView(
      child: Column(
        children: [
          enjoyBar(
            context,
            text: 'Enjoy our products',
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              onChanged: (value) {
                productsCubit.filterProducts(input: value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[350],
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black45),
                suffixIcon: IconButton(
                  onPressed: () {
                    // TODO:clear text
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black45,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black45,
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
          ), // SEARCH BAR
          const SizedBox(
            height: 15,
          ),
          //bannersListView(pageController, bannersCubit),
          BlocBuilder<BannerCubit, BannerState>(
            builder: (context, state) {
              if (state is BannerSuccess) {
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: bannersCubit.bannersList.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: SizedBox(
                              height: 200,
                              width: 350,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Image.network(
                                  '${bannersCubit.bannersList[index].imageUrl}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
                  ],
                );
              } else if (state is BannerFailure) {
                return const SizedBox(height: 150, child: CustomErrorWidget());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
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
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesSuccess) {
                return categoriesListView(context, categoriesCubit);
              } else if (state is CategoriesFailure) {
                return const SizedBox(
                  height: 150,
                  child: CustomErrorWidget(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: twoTextsRow(fText: 'Products', sText: 'View All'),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    height: 500,
                    child: productsCubit.productsModelList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                      itemCount:
                      productsCubit.filteredProductsModelList.isEmpty
                          ? productsCubit.productsModelList.length
                          : productsCubit
                          .filteredProductsModelList.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        var productModel = productsCubit
                            .filteredProductsModelList.isEmpty
                            ? productsCubit.productsModelList[index]
                            : productsCubit
                            .filteredProductsModelList[index];
                        var cubit = favoritesCubit;
                        return Stack(children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          favoritesCubit
                                              .favoritesProductsId
                                              .contains(productModel
                                              .id
                                              .toString())
                                              ? Icons.favorite_rounded
                                              : Icons
                                              .favorite_border_rounded,
                                          color: favoritesCubit
                                              .favoritesProductsId
                                              .contains(productModel
                                              .id
                                              .toString())
                                              ? Colors.red
                                              : color8,
                                        ),
                                        onPressed: () async {
                                          await cubit
                                              .addOrRemoveFavorites(
                                              productId: productModel
                                                  .id
                                                  .toString());
                                          setState(() {});
                                        },
                                      ),
                                      const Spacer(),
                                      productModel.discount != 0
                                          ? Center(
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                              5,
                                            ),
                                            color:
                                            Colors.greenAccent,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Sale -${productModel.discount}%',
                                              style:
                                              const TextStyle(
                                                color: color4,
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily:
                                                'DancingScript',
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  Container(
                                    height: 165,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${productModel.image}',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${productModel.name}',
                                    style: const TextStyle(
                                      color: color6,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        productModel.oldPrice ==
                                            productModel.price
                                            ? Text(
                                          '${productModel.price}',
                                          style: const TextStyle(
                                            color: color8,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        )
                                            : Row(
                                          children: [
                                            Text(
                                              '${productModel.oldPrice}\$',
                                              style: const TextStyle(
                                                color: color6,
                                                decoration:
                                                TextDecoration
                                                    .lineThrough,
                                                decorationColor:
                                                Colors.red,
                                                decorationThickness:
                                                1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${productModel.price}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () async {
                                await cartsCubit.addOrRemoveCarts(
                                    productId:
                                    productModel.id.toString());
                                setState(() {

                                },);
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: const BoxDecoration(
                                  color: color9,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                      20,
                                    ),
                                    topLeft: Radius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  cartsCubit.cartsProductsId.contains(
                                      productModel.id.toString())
                                      ? Icons.check
                                      : Icons.add,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      },
                    ),
                  ),
                );
              } else if (state is ProductsFailure) {
                return const SizedBox(height: 150, child: CustomErrorWidget());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
