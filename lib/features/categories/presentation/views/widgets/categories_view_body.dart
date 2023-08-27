import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/core/widgets/enjoy_bar.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
  builder: (context, state) {
    if(state is CategoriesSuccess){
      return Column(
        children: [
          enjoyBar(context, text: 'Categories'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: categoriesCubit.categoriesList.length,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            width: 160,
                            child: Text(
                              '${categoriesCubit.categoriesList[index].name}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              width: 210,
                              height: 155,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${categoriesCubit.categoriesList[index].image}',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Colors.white10,
                                  border:
                                  Border.all(color: Colors.indigo, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
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
    else if (state is CategoriesFailure){
      return Column(
        children: [
          enjoyBar(context, text: 'Categories'),
          CustomErrorWidget(),
        ],
      );
    }
    else{
      return Center(child: CircularProgressIndicator(),);
    }
  },
);
  }

  Container categoryItem(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    'Category Name Category Name Category Name ',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '12 Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                width: 210,
                height: 155,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://cdn.dribbble.com/userupload/7770883/file/original-58b365cc6be2e91033a12521d548ebd1.png?resize=1024x768',
                      ),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white10,
                    border: Border.all(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
