import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/features/card/presentation/managers/carts_cubit.dart';
import 'package:ecommerce/features/favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/enjoy_bar.dart';
import '../../../../../core/widgets/show_snack_bar.dart';

class CardViewBody extends StatefulWidget {
  const CardViewBody({Key? key}) : super(key: key);

  @override
  State<CardViewBody> createState() => _CardViewBodyState();
}

class _CardViewBodyState extends State<CardViewBody> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CartsCubit>(context);
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocConsumer<CartsCubit, CartsState>(
      listener: (context, state) {
        if(state is CartsFailure|| state is AddOrRemoveCartFailure){
          showSnackBar(context: context,label: 'No Internet Connection',backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        if(state is CartsSuccess||state is AddOrRemoveCartSuccess){
          return Column(
            children: [
              enjoyBar(context, text: 'Cards'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  child:cubit.cartsList.isNotEmpty? ListView.builder(
                    itemCount: cubit.cartsList.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.indigo,
                              width: 3,
                            ),
                            color: Colors.blueGrey,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 17, right: 5),
                                child: Container(
                                  height: 155,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${cubit.cartsList[index].image}',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.white10,
                                      border: Border.all(
                                          color: Colors.indigo, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      '${cubit.cartsList[index].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                      width: 170,
                                      child: cubit.cartsList[index].oldPrice ==
                                          cubit.cartsList[index].price
                                          ? Text(
                                        '${cubit.cartsList[index].price}\$',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                          : Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${cubit.cartsList[index].oldPrice}\$',
                                                style: const TextStyle(
                                                  color: Colors.grey,
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
                                                '${cubit.cartsList[index].price}\$',
                                                maxLines: 3,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  const Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async{
                                          await favoritesCubit.addOrRemoveFavorites(
                                              productId: cubit.cartsList[index].id.toString());
                                          setState(() {

                                          });
                                          showSnackBar(label: 'product removed ', context: context,backgroundColor: Colors.green);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: favoritesCubit
                                              .favoritesProductsId
                                              .contains(cubit
                                              .cartsList[index].id
                                              .toString())
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 45,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8.0),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                              Colors.red,
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  18,
                                                ),
                                              ),
                                            ),
                                            padding:
                                            const MaterialStatePropertyAll(
                                                EdgeInsets.fromLTRB(
                                                    30, 10, 30, 10)),
                                            side: MaterialStateProperty.all(
                                              const BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            cubit.addOrRemoveCarts(productId: cubit.cartsList[index].id.toString());
                                            setState(() {

                                            });
                                          },
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ):
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.5,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Lottie.asset(
                            'assets/lottie_json_animations/no_carts_products.json',
                            reverse: true,
                          ),
                        ),
                        const Text(
                          'No Carts Products',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                //     :
                // SizedBox(
                // height: MediaQuery.sizeOf(context).height*0.5,
                // child: Column(
                // children: [
                // Lottie.asset(
                // 'assets/lottie_json_animations/animation_llnsj0db.json',
                // reverse: true,
                // ),
                //  Text(
                // 'No Favorites Products',
                // style: TextStyle(
                // fontSize: 25,
                // ),
                // ),
                // ],
                // ),
                // )
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Total Price: ',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: '${cubit.total}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    const TextSpan(
                      text: '\$',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        else if (state is CartsFailure|| state is AddOrRemoveCartFailure){
          return Column(
            children: [
              enjoyBar(context, text: 'Cards'),
              const Center(child: CustomErrorWidget()),
            ],
          );
        }
        else {
          return Column(
            children: [
              enjoyBar(context, text: 'Cards'),
              const Center(child: CircularProgressIndicator(),),
            ],
          );
        }
      },
    );
  }
}
