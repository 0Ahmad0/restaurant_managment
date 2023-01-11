
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/model/models.dart' as model;
import 'package:restaurant_managment/view/manager/const.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/order_provider.dart';
import '../../../translations/locale_keys.g.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.meal,
  }) : super(key: key);
  final String name;
  final String price;
  final Meal meal;
  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider= Provider.of<OrderProvider>(context);
    return Card(
      elevation: AppSize.s12,
      shadowColor: ColorManager.primaryColor.withOpacity(.5),
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m24, vertical: AppMargin.m8),
      child: Stack(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(AppPadding.p40),
            title: Text(
              name,
              style: getBoldStyle(
                  color: ColorManager.primaryColor, fontSize: 12.sp),
            ),
            subtitle: Wrap(
              children: [
                for (var i = 0; i < ingredients.length; i++)
                  Text(
                    ingredients[i] + ' , ',
                    style: getLightStyle(
                        color: ColorManager.secondaryColor, fontSize: 8.sp),
                  ),
              ],
            ),
            trailing: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: price,
                  style: getRegularStyle(
                      color: ColorManager.black, fontSize: 8.sp)),
              TextSpan(
                  text: ' ' + tr(LocaleKeys.sr),
                  style:
                      getLightStyle(color: ColorManager.error, fontSize: 8.sp)),
            ])),

            // trailing: Text(ConstApp.meals[index].price + "SR",style: getRegularStyle(color: ColorManager.black,),),
          ),
          Positioned(
              bottom: 5.sp,
              left: 5.sp,
              child: GestureDetector(
                onTap: (){
               //   print('add sucess');
                  ConstApp.myOrder.addAll({});
                  if(!orderProvider.orders.orders.containsKey(meal.id)){
                    orderProvider.orders.orders[meal.id]=model.Order(meal: meal, orderId:"${Timestamp.now().seconds}", orderTime: DateTime.now(),count: 1);
                  }
                  else
                    orderProvider.orders.orders[meal.id]?.count++;
                  orderProvider.orders.totalPrice='${double.parse(orderProvider.orders.totalPrice)+double.parse(meal.price)}';
                  orderProvider.notifyListeners();
                },
                child: CircleAvatar(
                  radius: 10.sp,
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    size: 12.sp,
                  ),
                ),
              )
          ),

        ],
      ),
    );
  }
}
