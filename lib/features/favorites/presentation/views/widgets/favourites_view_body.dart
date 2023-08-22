import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/core/widgets/enjoy_bar.dart';
import 'package:flutter/material.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        enjoyBar(context, text: 'Favourites'),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: 30,
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
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4wtd9?ver=8b09',
                                ),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.white10,
                              border:
                                  Border.all(color: Colors.indigo, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 270,
                              child: Text(
                                'name',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 160,
                              child: Text(
                                '20\$',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 60, bottom: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red,),
                                  padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50,vertical: 15)),
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
                                    fontSize: 20,fontWeight: FontWeight.bold,
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
  }
}
