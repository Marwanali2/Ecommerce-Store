import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ecommerce/features/card/presentation/views/card_view.dart';
import 'package:ecommerce/features/categories/presentation/views/categories_view.dart';
import 'package:ecommerce/features/favorites/presentation/views/favourites_view.dart';
import 'package:ecommerce/features/home/presentation/views/home_view.dart';
import 'package:ecommerce/features/profile/presentation/views/profile_view.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int bottomNavCurrentIndex=0;
  void onBottomNavIndexChange({required int index}){
    bottomNavCurrentIndex=index;
    emit(ChangeBottomNavIndexState());
  }
  List<Widget> screens=[
    HomeView(),
    CategoriesView(),
    FavouriteView(),
    CardView(),
    ProfileView(),
  ];
}
