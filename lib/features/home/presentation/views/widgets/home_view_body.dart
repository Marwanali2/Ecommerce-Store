import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/utils/app_router.dart';
import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'dart:developer';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/enjoy_bar.dart';
import '../../../../../core/widgets/show_snack_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../main.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../../../layout/presentation/managers/layout_cubit.dart';
import '../../../../layout/presentation/views/layout_view.dart';
import '../../../../splach/presentation/splach_view.dart';
import '../../../data/models/products_model.dart';
import '../../managers/products_cubit/products_cubit.dart';
import 'banner_section.dart';
import 'categories_tap_products_section.dart';
import 'categories_taps_section.dart';
import 'package:intl/intl.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  static bool isElectronicDevices = true;
  static bool isPreventCorona = false;
  static bool isSports = false;
  static bool isLighting = false;
  static bool isClothes = false;
  static bool isAR = isArabic();
  static bool isEn = isEnglish();

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

List<ProductModel> getCategoryProductsFromHive() {
  var box = Hive.box(kCategoriesProducts);
  List<ProductModel> products = [];

  for (var i = 0; i < box.length; i++) {
    Map<dynamic, dynamic> productJson = box.getAt(i);
    products.add(
      ProductModel.fromJson(
        productJson,
      ),
    );
  }

  return products;
}

List<ProductModel> localProducts = getCategoryProductsFromHive();

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    var bannersCubit = BlocProvider.of<BannerCubit>(context);
    var categoriesCubit = BlocProvider.of<CategoriesCubit>(context)
      ..getCategoryProducts(categoryId: 44);
    var productsCubit = BlocProvider.of<ProductsCubit>(context);
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    var cartsCubit = BlocProvider.of<CartsCubit>(context);
    final pageController = PageController();
    TextEditingController textController = TextEditingController();
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.88,
      child: ListView(
        scrollDirection: Axis.vertical,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          enjoyBar(
            context,
            text: S.of(context).appBarTitle,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: FadeInDown(
                child: SearchTextField(
                  textController: textController,
                  productsCubit: productsCubit,
                  favoritesCubit: favoritesCubit,
                  cartsCubit: cartsCubit,
                ),
              ) //buildSearchTextFormField(textController, productsCubit, context, favoritesCubit, cartsCubit),
              ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  S.of(context).categorySelection,
                  style: TextStyle(
                    color: color4,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => LayoutView(),));
                    S.load(const Locale('en'));
                    setState(() {});
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      backgroundColor: Intl.getCurrentLocale() == 'en'
                          ? const MaterialStatePropertyAll(color9)
                          : const MaterialStatePropertyAll(Colors.blueGrey)),
                  child: const Text(
                    'EN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                ElevatedButton(
                  onPressed: () {
                    S.load(const Locale('ar'));
                    setState(() {});
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      backgroundColor: Intl.getCurrentLocale() == 'ar'
                          ? const MaterialStatePropertyAll(color9)
                          : const MaterialStatePropertyAll(Colors.blueGrey)),
                  child: const Text(
                    'AR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FadeInLeft(
                child: CategoriesTaps(categoriesCubit: categoriesCubit),
              ) //buildCategoriesNamesListView(categoriesCubit),
              ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              // final box = await Hive.openBox('kCategoriesProducts');
              // final dataList = box.get('data', defaultValue: []) as List<dynamic>;
              // final categoryList = dataList.map((data) => CategoryModel.fromJson(data)).toList();
              if (state is CategoryProductsSuccess) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: CategoryTapProductsListView(
                        categoriesCubit: categoriesCubit,
                        favoritesCubit: favoritesCubit,
                        cartsCubit: cartsCubit));
              } else if (state is CategoryProductsFailure) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.49,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      var cubit = favoritesCubit;
                      return Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      categoriesCubit
                                                  .categoryProductsLocalList[
                                                      index]
                                                  .discount !=
                                              0
                                          ? Center(
                                              child: Container(
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5,
                                                  ),
                                                  color: Colors.greenAccent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${S.of(context).productSale} -${categoriesCubit.categoryProductsLocalList[index].discount}%',
                                                    style: TextStyle(
                                                      color: color4,
                                                      fontSize: 13.sp,
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
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${categoriesCubit.categoryProductsLocalList[index].image}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        height: 165,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              '${categoriesCubit.categoryProductsLocalList[index].image}',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    '${categoriesCubit.categoryProductsLocalList[index].name}',
                                    style: const TextStyle(
                                      color: color6,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        categoriesCubit
                                                    .categoryProductsLocalList[
                                                        index]
                                                    .oldPrice ==
                                                categoriesCubit
                                                    .categoryProductsLocalList[
                                                        index]
                                                    .price
                                            ? Text(
                                                '${categoriesCubit.categoryProductsLocalList[index].price}',
                                                style: const TextStyle(
                                                  color: color8,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                    '${categoriesCubit.categoryProductsLocalList[index].oldPrice}\$',
                                                    style: const TextStyle(
                                                      color: color6,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.red,
                                                      decorationThickness: 1.5,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${categoriesCubit.categoryProductsLocalList[index].price}',
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
                        ],
                      );
                    },
                  ),
                );
              } else {
                // return const Center(child: CircularProgressIndicator());
                return FadeInUp(
                  animate: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 200.w,
                            height: 100.h,
                            child: Shimmer.fromColors(
                              baseColor: color9,
                              highlightColor: color9.withOpacity(
                                0.5,
                              ),
                              period: const Duration(milliseconds: 500),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              S.of(context).bannerText,
              style: TextStyle(
                color: color4,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<BannerCubit, BannerState>(
            builder: (context, state) {
              if (state is BannerSuccess) {
                return BannerSection(
                    pageController: pageController, bannersCubit: bannersCubit);
              } else if (state is BannerFailure) {
                return SizedBox(
                    height: 150.h, child: const CustomErrorWidget());
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 150.h,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Shimmer.fromColors(
                        baseColor: color9,
                        highlightColor: color9.withOpacity(
                          0.5,
                        ),
                        period: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
