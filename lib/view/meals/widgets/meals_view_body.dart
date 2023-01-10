import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/controller/order_provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/ShadowContainer.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/const.dart';
import 'meal_item.dart';

class MealsViewBody extends StatelessWidget {
  const MealsViewBody({Key? key, required this.image,required this.meals}) : super(key: key);
  final String image;
  final List meals;

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
              itemCount: meals.length,
              itemBuilder: (_, index) {
                return MealItem(
                  name: (Advance.language)? meals[index].mealNameAr:meals[index].mealNameEn,
                  price: meals[index].price,//ConstApp.meals[index].price,
                  ingredients:[(Advance.language)? meals[index].mealDetailsAr:meals[index].mealDetailsEn],
                  meal:meals[index]
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
