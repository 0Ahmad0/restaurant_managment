import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/my_orders/my_orders_view.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import '../../resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../shopping_cart/shopping_cart_view.dart';

class CartShoppingWidget extends StatefulWidget {
  const CartShoppingWidget({Key? key, this.counter}) : super(key: key);
  final int? counter;

  @override
  State<CartShoppingWidget> createState() => _CartShoppingWidgetState();
}

class _CartShoppingWidgetState extends State<CartShoppingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSize.s40),
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.s40)
          )
      ),
      child: Wrap(
        children: [
          ...List.generate(30, (index) =>
              Container(
                margin: const EdgeInsets.all(AppMargin.m8),
                child: Chip(
                  label: Text('${index + 1}',
                    style: getRegularStyle(color: ColorManager.black,
                        fontSize: 12.sp
                    ),),
                  onDeleted: () {},
                ),
              )),
          ButtonApp(text: tr(LocaleKeys.my_orders),
              onPressed: () =>
                  Get.to(() => MyOrdersView(),
                      transition: Transition.size)
          )
        ],
      ),
    );
  }
}
