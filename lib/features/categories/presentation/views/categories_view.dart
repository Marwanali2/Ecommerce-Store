import 'package:ecommerce/features/categories/presentation/views/widgets/categories_view_body.dart';
import 'package:flutter/material.dart';
class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoriesViewBody(),
    );
  }
}
