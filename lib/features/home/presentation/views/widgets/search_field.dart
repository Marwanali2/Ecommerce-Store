import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../managers/products_cubit/products_cubit.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {Key? key,
      required this.textController,
      required this.productsCubit,
      required this.favoritesCubit,
      required this.cartsCubit})
      : super(key: key);
  final TextEditingController textController;
  final ProductsCubit productsCubit;
  final FavoritesCubit favoritesCubit;
  final CartsCubit cartsCubit;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: color2,
        contentPadding: const EdgeInsets.all(20),
        hintText: S.of(context).searchText,
        hintStyle: const TextStyle(color: color6, fontSize: 15),
        suffixIcon: IconButton(
          onPressed: () {
            widget.textController.clear();
          },
          icon: const Icon(
            Icons.close,
            color: color6,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: color6,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
      ),
      controller: widget.textController,
      onChanged: (value) {
        widget.productsCubit.filterProducts(input: value);
      },
      onFieldSubmitted: (value) {
        widget.productsCubit.filterProducts(input: value);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              // Bottom sheet content
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width * 0.95,
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SizedBox(
                      height: 500,
                      child: widget
                              .productsCubit.filteredProductsModelList.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 200,
                                    child: Lottie.asset(
                                        'assets/lottie_json_animations/no_products.json')),
                                const Text('Not Available Now'),
                              ],
                            )
                          : GridView.builder(
                              itemCount: widget.productsCubit
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
                                var productModel = widget.productsCubit
                                    .filteredProductsModelList[index];
                                var cubit = widget.favoritesCubit;
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
                                                  widget.favoritesCubit
                                                          .favoritesProductsId
                                                          .contains(productModel
                                                              .id
                                                              .toString())
                                                      ? Icons.favorite_rounded
                                                      : Icons
                                                          .favorite_border_rounded,
                                                  color: widget.favoritesCubit
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
                                                          productId:
                                                              productModel.id
                                                                  .toString());
                                                  setState(() {});
                                                },
                                              ),
                                              const Spacer(),
                                              productModel.discount != 0
                                                  ? Center(
                                                      child: Container(
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                          color: Colors
                                                              .greenAccent,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${S.of(context).productSale} -${productModel.discount}%',
                                                            style:
                                                                const TextStyle(
                                                              color: color4,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
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
                                                          fontSize: 20,
                                                        ),
                                                      )
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            '${productModel.oldPrice}\$',
                                                            style:
                                                                const TextStyle(
                                                              color: color6,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              decorationColor:
                                                                  Colors.red,
                                                              decorationThickness:
                                                                  1.5,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '${productModel.price}',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
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
                                                    fontSize: 15,
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
                                        await widget.cartsCubit
                                            .addOrRemoveCarts(
                                                productId:
                                                    productModel.id.toString());
                                        setState(
                                          () {},
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
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
                                          widget.cartsCubit.cartsProductsId
                                                  .contains(productModel.id
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
                            ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
