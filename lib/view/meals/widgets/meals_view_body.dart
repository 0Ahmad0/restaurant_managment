import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/ShadowContainer.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/const.dart';
import 'meal_item.dart';

class MealsViewBody extends StatelessWidget {
  const MealsViewBody({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Hero(
                tag: image,
                child: ShadowContainer(
                  margin: AppSize.s24,
                  padding: 0.0,
                  radius: AppSize.s24,
                  child: Container(
                    width: double.infinity,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s24),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage(image))),
                  ),
                )),
            Expanded(
                child: ListView.builder(
              itemCount: ConstApp.meals.length,
              itemBuilder: (_, index) {
                return MealItem(
                  name: ConstApp.meals[index].name,
                  price: ConstApp.meals[index].price,
                  ingredients: ConstApp.meals[index].ingredients,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
