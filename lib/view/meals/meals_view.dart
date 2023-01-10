import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/order_provider.dart';

import '../manager/widgets/custom_float_actionbutton.dart';
import 'widgets/cart_shopping_widget.dart';
import 'widgets/meals_view_body.dart';

class MealsView extends StatelessWidget {
  const MealsView({Key? key, required this.title, required this.image,required this.meals}) : super(key: key);
  final String title;
  final String image;
  final List meals;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: CustomFloatActionButton(),
        appBar: AppBar(
          title: Text(title),
        ),
        body: MealsViewBody(image: image,meals:meals),
    );
  }
}
