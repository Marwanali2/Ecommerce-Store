import 'package:ecommerce/features/favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/proudct_details_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../../../core/utils/colors.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../../core/widgets/show_snack_bar.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';

class ProductDetailsView extends StatefulWidget {
  final int? id;
  final int? price;
  final int? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;
  final List<dynamic>? images;

  const ProductDetailsView({
    Key? key,
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
  }) : super(key: key);
  static int currentPage = 0;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    var cartsCubit = BlocProvider.of<CartsCubit>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: color2,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailsAppBar(discount: widget.discount!),
                const SizedBox(
                  height: 20,
                ),
                ReadMoreText(
                  widget.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Read more',
                  trimExpandedText: '  Read less',
                  moreStyle: const TextStyle(
                    color: color9,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  lessStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.oldPrice == widget.price
                    ? Text(
                        '\$ ${widget.price!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      )
                    : Row(
                        children: [
                          Text(
                            '\$${widget.oldPrice!}',
                            style: const TextStyle(
                              color: color6,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 1.5,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '\$${widget.price!}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 400,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.images?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ZoomOverlay(
                            // modalBarrierColor: Colors.black12, // Optional
                            minScale: 0.5,
                            // Optional
                            maxScale: 5.0,
                            // Optional
                            animationCurve: Curves.elasticInOut,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn
                            twoTouchOnly: true,
                            // Defaults to false
                            child: Image.network(
                              '${widget.images![index]}',
                            ),
                          );
                        },
                        onPageChanged: (int value) {
                          setState(() {
                            ProductDetailsView.currentPage = value;
                          });
                        },
                      ),
                    );
                  },
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/Ellipse 5.svg',
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.38,
                    ),
                    DotsIndicator(
                      dotsCount: widget.images!.length,
                      position: ProductDetailsView.currentPage,
                      decorator: const DotsDecorator(
                        activeColor: Colors.indigo,
                        size: Size.square(9.0),
                        activeSize: Size(20, 20),
                        activeShape: StarBorder(),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: color9,
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Zoom Image With Your Fingers',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: color9,
                        child: Text(
                          'i',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  widget.description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: color5,
                  ),
                  trimLines: 6,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '  Read more',
                  trimExpandedText: '  Read less',
                  moreStyle: const TextStyle(
                    color: color9,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  lessStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: color3,
                        maxRadius: 30,
                        child: BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            return IconButton(
                              icon: Icon(
                                favoritesCubit.favoritesProductsId
                                        .contains(widget.id.toString())
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                size: 25,
                              ),
                              color: favoritesCubit.favoritesProductsId
                                      .contains(widget.id.toString())
                                  ? Colors.red
                                  : Colors.black,
                              onPressed: () {
                                setState(() {
                                  favoritesCubit
                                      .addOrRemoveFavorites(
                                      productId: widget.id.toString());
                                });
                                favoritesCubit.favoritesProductsId
                                    .contains(widget.id.toString())
                                    ? showSnackBar(
                                    context: context,
                                    label:
                                    "Removed From Favourites successfully",
                                    backgroundColor: Colors.red)
                                    : showSnackBar(
                                    context: context,
                                    label:
                                    "Added to Favourites successfully",
                                    backgroundColor: color9);
                              },
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            cartsCubit.addOrRemoveCarts(
                                productId: widget.id.toString());
                            cartsCubit.cartsProductsId
                                    .contains(widget.id.toString())
                                ? showSnackBar(
                                    context: context,
                                    label: "Removed From Carts successfully",
                                    backgroundColor: Colors.red)
                                : showSnackBar(
                                    context: context,
                                    label: "Added to carts successfully",
                                    backgroundColor: color9);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            color9,
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).width * 0.15,
                              vertical: 15,
                            ),
                          ),
                        ),
                        child: BlocBuilder<CartsCubit, CartsState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                cartsCubit.cartsProductsId
                                        .contains(widget.id.toString())
                                    ? const Icon(
                                        Icons.remove_shopping_cart_rounded,
                                        color: Colors.white,
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/cart_bag.svg'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cartsCubit.cartsProductsId
                                          .contains(widget.id.toString())
                                      ? 'Remove From Carts'
                                      : 'Add To Cart',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
