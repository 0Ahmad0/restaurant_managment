import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/utils/function_helper_view_provider.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/my_orders/my_orders_view.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import '../../../controller/order_provider.dart';
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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.s40)
          )
      ),
      child:
      ChangeNotifierProvider<OrderProvider>.value(
    value: Provider.of<OrderProvider>(context),
    child: Consumer<OrderProvider>(
    builder: (context, value, child) =>
      Wrap(
        children: [
          ...List.generate(value.orders.orders.keys.length, (index) =>
              Container(
                margin: const EdgeInsets.all(AppMargin.m8),
                child: Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text('${FunctionHelperViewProvider.chooseNameByLanguage(ar:value.orders.orders.values.elementAt(index).meal?.mealNameAr, en:value.orders.orders.values.elementAt(index).meal?.mealNameEn )
                  } ${value.orders.orders.values.elementAt(index).count}',/*${index + 1}*/
                    style: getRegularStyle(
                        color:Theme.of(context).textTheme.subtitle1!.color,
                        fontSize: 12.sp
                    ),),
                  onDeleted: () {
                    value.orders.totalPrice='${double.parse( value.orders.totalPrice)-double.parse(value.orders.orders.values.elementAt(index).meal!.price)}';
                    if(value.orders.orders.values.elementAt(index).count<=1)
                      value.orders.orders.remove(value.orders.orders.keys.elementAt(index));
                    else
                      value.orders.orders.values.elementAt(index).count--;
                    value.notifyListeners();
                  },
                ),
              )),
          ButtonApp(text: tr(LocaleKeys.my_orders),
              onPressed: () =>
                Get.to(() => MyOrdersView(),transition: Transition.size)
          )
        ],
      ),))
    );
  }
}
