import 'package:ecommerce/features/favorites/presentation/views/widgets/favourites_view_body.dart';
import 'package:flutter/material.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavouriteViewBody(),
    );
  }
}
