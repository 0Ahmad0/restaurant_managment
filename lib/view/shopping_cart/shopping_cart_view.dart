import 'package:flutter/material.dart';

import 'widget/shopping_cart_view_body.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShoppingCartViewBody(),
    );
  }
}
