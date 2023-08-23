import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/core/widgets/enjoy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../managers/favorites_cubit/favorites_cubit.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        // else if(state is FavoritesFailure){
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         content: Text(
        //           state.errorMessage,
        //           style: const TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //         backgroundColor: Colors.red,
        //       );
        //     },
        //   );
        // }
      },
      builder: (context, state) {
        return Column(
          children: [
            enjoyBar(context, text: 'Favourites'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: cubit.favoritesModelList.isEmpty
                  ? Column(
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
                    )
                  : ListView.builder(
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
                                  padding: const EdgeInsets.only(left: 17),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 270,
                                        child: Text(
                                          '${cubit.favoritesModelList[index].name}',
                                          maxLines: 3,
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
                                        width: 160,
                                        child: Text(
                                          '${cubit.favoritesModelList[index].price}\$',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60, bottom: 10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.red,
                                            ),
                                            padding:
                                                const MaterialStatePropertyAll(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 15)),
                                            side: MaterialStateProperty.all(
                                              const BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
