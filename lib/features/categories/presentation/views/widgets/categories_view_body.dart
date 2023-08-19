import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 15,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return _productItem();
            },
          ),
        ),
      ),
    );
  }
}
Widget _productItem() {
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
        children: [
          Row(
            children: [
              const Row(
                children: [
                  Text(
                    '18',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 3,),
                  Text(
                    '\$',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/shopping-seamless-pattern-with-colorful-doodle_67074-1139.jpg',
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
          const Text(
            'موبايل شاومي ريدمي 10 بشريحتي اتصال - 6.53 بوصة فل اتش دي ، 64 جيجا ، 4 جيجا رام ، شبكة الجيل الرابع ال تي اي - رمادي كربوني',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            maxLines: 2,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
