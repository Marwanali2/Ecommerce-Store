import 'package:ecommerce/features/home/presentation/views/widgets/proudct_details_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../../../core/utils/colors.dart';

class ProductDetailsView extends StatefulWidget {
  final int? price;
  final int? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;
  final List<dynamic>? images;

  const ProductDetailsView({
    Key? key,
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
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 400,
                  child: PageView.builder(
                    itemCount: widget.images?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.network(
                        '${widget.images![index]}',
                      );
                    },
                    onPageChanged: (int value) {
                      setState(() {
                        ProductDetailsView.currentPage = value;
                      });
                    },
                  ),
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/Ellipse 5.svg',
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                Center(
                  child: DotsIndicator(
                    dotsCount: widget.images!.length,
                    position: ProductDetailsView.currentPage,
                    decorator: const DotsDecorator(
                      activeColor: Colors.indigo,
                      size: Size.square(9.0),
                      activeSize: Size(20, 20),
                      activeShape: StarBorder(),
                    ),
                  ),
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
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            size: 25,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/cart_bag.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Add To Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
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
