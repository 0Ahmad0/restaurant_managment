import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/model/utils/const.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/home/home_view.dart';
import 'package:sizer/sizer.dart';

import '../../controller/order_provider.dart';
import '../../controller/profile_provider.dart';
import '../../controller/utils/firebase.dart';
import 'widgets/my_orders_view_body.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.my_orders)),
      ),
      floatingActionButton:
      ChangeNotifierProvider<OrderProvider>.value(
    value: Provider.of<OrderProvider>(context),
    child: Consumer<OrderProvider>(
    builder: (context, value, child) =>
      SizedBox(
        width: 15.w,
        height: 15.h,
        child: FloatingActionButton(
          onPressed: () async {
            if(value.orders.orders.keys.length<1)
              Const.TOAST(context,textToast: FirebaseFun.findTextToast(tr(LocaleKeys.no_dishes_cart)));
            else{
              Const.LOADIG(context);
              value.orders.idUser=profileProvider.user.id;
              final result=await value.addOrder(context, orders: value.orders);
              Get.back();
              if(result['status']) {
                value.orders=Orders(orders: {}, id: "", idUser: "", orderTime:  DateTime.now());
                value.notifyListeners();
                Get.to(() => HomeView());
              }
            }

          },
          child: Icon(Icons.done,size: 5.w,),
        ),
      ),)),
      body: MyOrdersViewBody(),
    );
  }
}
