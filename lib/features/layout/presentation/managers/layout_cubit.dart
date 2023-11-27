import 'package:ecommerce/features/card/presentation/views/widgets/card_view_body.dart';
import 'package:ecommerce/features/favorites/presentation/views/widgets/favourites_view_body.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  //int bottomNavCurrentIndex=0;
  int bottomNavCurrentIndex = 0;
  void onBottomNavIndexChange({required int index}) {
    bottomNavCurrentIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  List<Widget> screens = [
    const HomeViewBody(),
    //CategoriesViewBody(),
    const FavouriteViewBody(),
    const CardViewBody(),
  ];
}
