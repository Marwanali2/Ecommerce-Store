import 'package:ecommerce/features/card/presentation/views/widgets/card_view_body.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: CardViewBody(),
    );
  }
}
