// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/product_details_view.dart';

import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/widgets/show_snack_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../managers/categories_cubit/categories_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryTapProductsListView extends StatefulWidget {
  const CategoryTapProductsListView(
      {Key? key,
      required this.categoriesCubit,
      required this.favoritesCubit,
      required this.cartsCubit})
      : super(key: key);

  final CategoriesCubit categoriesCubit;
  final FavoritesCubit favoritesCubit;
  final CartsCubit cartsCubit;

  @override
  State<CategoryTapProductsListView> createState() =>
      _CategoryTapProductsListViewState();
}

class _CategoryTapProductsListViewState
    extends State<CategoryTapProductsListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.49,
      child: buildGridView(),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.categoriesCubit.categoryProductsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 20,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        var cubit = widget.favoritesCubit;
        return Stack(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductDetailsView(
                      id: widget.categoriesCubit.categoryProductsList[index].id,
                      price: widget
                          .categoriesCubit.categoryProductsList[index].price,
                      oldPrice: widget
                          .categoriesCubit.categoryProductsList[index].oldPrice,
                      discount: widget
                          .categoriesCubit.categoryProductsList[index].discount,
                      image: widget
                          .categoriesCubit.categoryProductsList[index].image,
                      name: widget
                          .categoriesCubit.categoryProductsList[index].name,
                      description: widget.categoriesCubit
                          .categoryProductsList[index].description,
                      images: widget
                          .categoriesCubit.categoryProductsList[index].images,
                    );
                  },
                ),
              );
            },
            child: FadeInUp(
              animate: true,
              child: Container(
                decoration: const BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              widget.favoritesCubit.favoritesProductsId
                                      .contains(widget.categoriesCubit
                                          .categoryProductsList[index].id
                                          .toString())
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: widget.favoritesCubit.favoritesProductsId
                                      .contains(widget.categoriesCubit
                                          .categoryProductsList[index].id
                                          .toString())
                                  ? Colors.red
                                  : color8,
                            ),
                            onPressed: () async {
                              await cubit.addOrRemoveFavorites(
                                  productId: widget.categoriesCubit
                                      .categoryProductsList[index].id
                                      .toString());
                              setState(() {});
                              widget.favoritesCubit.favoritesProductsId
                                      .contains(widget.categoriesCubit
                                          .categoryProductsList[index].id
                                          .toString())
                                  ?
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(
                                      context: context,
                                      label: S.of(context).snackAddFav,
                                      backgroundColor: color9)
                                  : showSnackBar(
                                      context: context,
                                      label: S.of(context).snackDelFav,
                                      backgroundColor: Colors.red);
                            },
                          ),
                          const Spacer(),
                          widget.categoriesCubit.categoryProductsList[index]
                                      .discount !=
                                  0
                              ? Center(
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                      color: Colors.greenAccent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${S.of(context).productSale} -${widget.categoriesCubit.categoryProductsList[index].discount}%',
                                        style: const TextStyle(
                                          color: color4,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'DancingScript',
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
                            '${widget.categoriesCubit.categoryProductsList[index].image}',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 165,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  '${widget.categoriesCubit.categoryProductsList[index].image}',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        '${widget.categoriesCubit.categoryProductsList[index].name}',
                        style: const TextStyle(
                          color: color6,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: isArabic()
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start, //ar-end
                        children: [
                          widget.categoriesCubit.categoryProductsList[index]
                                      .oldPrice ==
                                  widget.categoriesCubit
                                      .categoryProductsList[index].price
                              ? Text(
                                  '${widget.categoriesCubit.categoryProductsList[index].price}',
                                  style: const TextStyle(
                                    color: color8,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Text(
                                      '${widget.categoriesCubit.categoryProductsList[index].oldPrice}\$',
                                      style: const TextStyle(
                                        color: color6,
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
                                      '${widget.categoriesCubit.categoryProductsList[index].price}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () async {
                await widget.cartsCubit.addOrRemoveCarts(
                    productId: widget
                        .categoriesCubit.categoryProductsList[index].id
                        .toString());
                setState(
                  () {},
                );
                widget.cartsCubit.cartsProductsId.contains(widget
                        .categoriesCubit.categoryProductsList[index].id
                        .toString())
                    ? showSnackBar(
                        context: context,
                        label: S.of(context).snackAddCard,
                        backgroundColor: color9,
                      )
                    : showSnackBar(
                        context: context,
                        label: S.of(context).snackDelCard,
                        backgroundColor: Colors.red,
                      );
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
                  widget.cartsCubit.cartsProductsId.contains(widget
                          .categoriesCubit.categoryProductsList[index].id
                          .toString())
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
    );
  }
}
