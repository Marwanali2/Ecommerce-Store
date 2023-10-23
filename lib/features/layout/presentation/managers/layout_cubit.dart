import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/card/presentation/views/widgets/card_view_body.dart';
import 'package:ecommerce/features/categories/presentation/views/widgets/categories_view_body.dart';
import 'package:ecommerce/features/favorites/presentation/views/widgets/favourites_view_body.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:ecommerce/features/layout/presentation/managers/settings.dart';
import 'package:ecommerce/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  //int bottomNavCurrentIndex=0;
  int bottomNavCurrentIndex=0;
  void onBottomNavIndexChange({required int index}){
    bottomNavCurrentIndex=index;
    emit(ChangeBottomNavIndexState());
  }
  List<Widget> screens=[
    HomeViewBody(),
    //CategoriesViewBody(),
    FavouriteViewBody(),
    CardViewBody(),
    SettingsViewBody(),
  ];
}
