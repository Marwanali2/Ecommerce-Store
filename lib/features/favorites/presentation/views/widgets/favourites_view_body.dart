import 'package:ecommerce/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../managers/favorites_cubit/favorites_cubit.dart';

class FavouriteViewBody extends StatefulWidget {
  const FavouriteViewBody({Key? key}) : super(key: key);

  @override
  State<FavouriteViewBody> createState() => _FavouriteViewBodyState();
}

class _FavouriteViewBodyState extends State<FavouriteViewBody> {
  @override
  Widget build(BuildContext context) {
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Column(children: [
          const Center(
            child: Text(
              'Favourites',
              style: TextStyle(
                color: color4,
                //fontFamily: 'DancingScript',
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: state is FavoritesLoading
                ? const CircularProgressIndicator()
                : favoritesCubit.favoritesModelList.isNotEmpty
                    ? SizedBox(height: MediaQuery.sizeOf(context).height*0.815,
                      child:ListView.builder(
                          itemCount: favoritesCubit.favoritesModelList.length,
                          scrollDirection: Axis.vertical,
                         // physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                         return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 180,
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(10,),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17, right: 10,),
                                    child: Container(
                                      height: 155,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              '${favoritesCubit.favoritesModelList[index].image}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        borderRadius:
                                              BorderRadius.circular(20,),),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      favoritesCubit.favoritesModelList[index].discount!=0?
                                      Center(
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
                                              'Sale -${favoritesCubit.favoritesModelList[index].discount}%',
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
                                          :const SizedBox(),
                                      const SizedBox(height: 20,),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width*0.5,
                                        child: Text(
                                          '${favoritesCubit.favoritesModelList[index].name}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: color10,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    //  const Spacer(),
                                      const SizedBox(height: 20,),
                                      SizedBox(
                                          width: MediaQuery.sizeOf(context).width*0.5,
                                          child: favoritesCubit.favoritesModelList[index]
                                                      .oldPrice ==
                                                  favoritesCubit
                                                      .favoritesModelList[index]
                                                      .price
                                              ? Text(
                                                  '${favoritesCubit.favoritesModelList[index].price}\$',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: color10,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${favoritesCubit.favoritesModelList[index].oldPrice}\$',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Colors.red,
                                                            decorationThickness:
                                                                1.5,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${favoritesCubit.favoritesModelList[index].price}\$',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: color10,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                      ),

                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       bottom: 10, left: 25),
                                      //   child: ElevatedButton(
                                      //     style: ButtonStyle(
                                      //       backgroundColor:
                                      //           MaterialStateProperty.all(
                                      //         Colors.red,
                                      //       ),
                                      //       shape: MaterialStateProperty.all(
                                      //         RoundedRectangleBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //             18,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       padding:
                                      //           const MaterialStatePropertyAll(
                                      //         EdgeInsets.symmetric(
                                      //           horizontal: 30,
                                      //           vertical: 15,
                                      //         ),
                                      //       ),
                                      //       side: MaterialStateProperty.all(
                                      //         const BorderSide(
                                      //           color: mainColor,
                                      //           width: 2,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     onPressed: () {
                                      //       setState(() {
                                      //         favoritesCubit.addOrRemoveFavorites(
                                      //             productId: favoritesCubit
                                      //                 .favoritesModelList[index]
                                      //                 .id
                                      //                 .toString());
                                      //       });
                                      //     },
                                      //     child: const Text(
                                      //       'Remove',
                                      //       style: TextStyle(
                                      //         color: color10,
                                      //         fontSize: 20,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                            // return Stack(children: [
                            //   Container(
                            //     decoration: const BoxDecoration(
                            //       color: color2,
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(20),
                            //       ),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 5),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               IconButton(
                            //                 icon: Icon(
                            //                    Icons.favorite_rounded,
                            //                   color:Colors.red
                            //                 ),
                            //                 onPressed: () async {
                            //                   await favoritesCubit.addOrRemoveFavorites(
                            //                       productId: categoriesCubit
                            //                           .categoryProductsList[index].id
                            //                           .toString());
                            //                   setState(() {});
                            //                 },
                            //               ),
                            //               const Spacer(),
                            //               favoritesCubit.favoritesModelList[index]
                            //                   .discount !=
                            //                   0
                            //                   ? Center(
                            //                 child: Container(
                            //                   width: 80,
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                     BorderRadius.circular(
                            //                       5,
                            //                     ),
                            //                     color: Colors.greenAccent,
                            //                   ),
                            //                   child: Center(
                            //                     child: Text(
                            //                       'Sale -${favoritesCubit.favoritesModelList[index].discount}%',
                            //                       style: const TextStyle(
                            //                         color: color4,
                            //                         fontSize: 15,
                            //                         fontWeight: FontWeight.bold,
                            //                         fontFamily: 'DancingScript',
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               )
                            //                   : const SizedBox(),
                            //             ],
                            //           ),
                            //           Container(
                            //             height: 165,
                            //             decoration: BoxDecoration(
                            //               image: DecorationImage(
                            //                 image: NetworkImage(
                            //                   '${favoritesCubit.favoritesModelList[index].image}',
                            //                 ),
                            //                 fit: BoxFit.fill,
                            //               ),
                            //             ),
                            //           ),
                            //           Text(
                            //             '${favoritesCubit.favoritesModelList[index].name}',
                            //             style: const TextStyle(
                            //               color: color6,
                            //               fontSize: 15,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //             maxLines: 2,
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //           const Spacer(),
                            //           Padding(
                            //             padding: const EdgeInsets.only(left: 5),
                            //             child: Row(
                            //               children: [
                            //                 favoritesCubit.favoritesModelList[index]
                            //                     .oldPrice ==
                            //                     favoritesCubit.favoritesModelList[index]
                            //                         .price
                            //                     ? Text(
                            //                   '${favoritesCubit.favoritesModelList[index].price}',
                            //                   style: const TextStyle(
                            //                     color: color8,
                            //                     fontWeight: FontWeight.bold,
                            //                     fontSize: 25,
                            //                   ),
                            //                 )
                            //                     : Row(
                            //                   children: [
                            //                     Text(
                            //                       '${favoritesCubit.favoritesModelList[index].oldPrice}\$',
                            //                       style: const TextStyle(
                            //                         color: color6,
                            //                         decoration: TextDecoration
                            //                             .lineThrough,
                            //                         decorationColor: Colors.red,
                            //                         decorationThickness: 1.5,
                            //                         fontSize: 14,
                            //                       ),
                            //                     ),
                            //                     const SizedBox(
                            //                       width: 5,
                            //                     ),
                            //                     Text(
                            //                       '${favoritesCubit.favoritesModelList[index].price}',
                            //                       style: const TextStyle(
                            //                         color: Colors.black,
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 17,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 const SizedBox(
                            //                   width: 1,
                            //                 ),
                            //                 const Text(
                            //                   '\$',
                            //                   style: TextStyle(
                            //                     color: mainColor,
                            //                     fontWeight: FontWeight.bold,
                            //                     fontSize: 17,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            //   Align(
                            //     alignment: Alignment.bottomRight,
                            //     child: GestureDetector(
                            //       onTap: () async {
                            //         await cartsCubit.addOrRemoveCarts(
                            //             productId: favoritesCubit.favoritesModelList[index].id
                            //                 .toString());
                            //         setState(
                            //               () {},
                            //         );
                            //       },
                            //       child: Container(
                            //         height: 45,
                            //         width: 45,
                            //         decoration: const BoxDecoration(
                            //           color: color9,
                            //           borderRadius: BorderRadius.only(
                            //             bottomRight: Radius.circular(
                            //               20,
                            //             ),
                            //             topLeft: Radius.circular(
                            //               20,
                            //             ),
                            //           ),
                            //         ),
                            //         child: Icon(
                            //           cartsCubit.cartsProductsId.contains(
                            //              favoritesCubit.favoritesModelList[index].id
                            //                   .toString())
                            //               ? Icons.check
                            //               : Icons.add,
                            //           color: Colors.white,
                            //           size: 35,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ]);

                          },
                        ),
                    )
                    : SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: Column(
                          children: [
                            Lottie.asset(
                              'assets/lottie_json_animations/no_favorite_products.json',
                              reverse: true,
                            ),
                            const Text(
                              'No Favorites Products',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ]);
      },
    );
  }
}
