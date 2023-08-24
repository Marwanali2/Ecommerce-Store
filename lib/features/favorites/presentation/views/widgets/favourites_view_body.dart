import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/core/widgets/enjoy_bar.dart';
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
    var cubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Column(
          children: [
            enjoyBar(context, text: 'Favourites'),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: state is FavoritesLoading? const CircularProgressIndicator():
               cubit.favoritesModelList.isNotEmpty?ListView.builder(
                        itemCount: cubit.favoritesModelList.length,
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
                                    padding: const EdgeInsets.only(
                                        left: 17, right: 5),
                                    child: Container(
                                      height: 155,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              '${cubit.favoritesModelList[index].image}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          color: Colors.white10,
                                          border: Border.all(
                                              color: Colors.indigo, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          '${cubit.favoritesModelList[index].name}',
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
                                          child: cubit.favoritesModelList[index]
                                                      .oldPrice ==
                                                  cubit
                                                      .favoritesModelList[index]
                                                      .price
                                              ? Text(
                                                  '${cubit.favoritesModelList[index].price}\$',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                          '${cubit.favoritesModelList[index].oldPrice}\$',
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
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${cubit.favoritesModelList[index].price}\$',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, left: 25),
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
                                              EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 15,
                                              ),
                                            ),
                                            side: MaterialStateProperty.all(
                                              const BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              cubit.addOrRemoveFavorites(
                                                  productId: cubit
                                                      .favoritesModelList[index]
                                                      .id
                                                      .toString());
                                            });
                                          },
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
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
                     Lottie.asset(
                       'assets/lottie_json_animations/animation_llnsj0db.json',
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
               )
            ),
          ],
        );
      },
    );
  }
}