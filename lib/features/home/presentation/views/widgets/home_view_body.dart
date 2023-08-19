import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/two_texts_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/utils/colors.dart';
import '../../../data/models/products_model.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(

              onChanged: (value) {
                setState(() {
                  productsCubit.filterProducts(input: value);
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[350],
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black45),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                    // TODO:clear text
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black45,
                  ),
                ),
                prefixIcon: const Icon(Icons.search,color: Colors.black45,),
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
                  : GridView.builder(
                      itemCount: productsCubit.filteredProductsModelList.isEmpty
                          ? productsCubit.productsModelList.length
                          : productsCubit.filteredProductsModelList.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return productItem(
                            productModel:
                                productsCubit.filteredProductsModelList.isEmpty
                                    ? productsCubit.productsModelList[index]
                                    : productsCubit
                                        .filteredProductsModelList[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget productItem({required ProductModel productModel}) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      border: Border.all(
        color: Colors.indigo,
        width: 2,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  productModel.oldPrice == productModel.price
                      ? Text(
                          '${productModel.price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              '${productModel.oldPrice}\$',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 1.5,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${productModel.price}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: mainColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  '${productModel.image}',
                ),
                fit: BoxFit.fill,
              ),
              color: Colors.white10,
              border: Border.all(color: Colors.indigo, width: 2),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(
                  20,
                ),
                topLeft: Radius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${productModel.name}',
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          productModel.discount != 0
              ? Center(
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        'Discount ${productModel.discount}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'DancingScript',
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
        ],
      ),
    ),
  );
}
