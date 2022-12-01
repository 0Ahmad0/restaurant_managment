import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/model/utils/const.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/home/home_view.dart';
import 'package:sizer/sizer.dart';

import 'widgets/my_orders_view_body.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.my_orders)),
      ),
      floatingActionButton: SizedBox(
        width: 15.w,
        height: 15.h,
        child: FloatingActionButton(
          onPressed: (){
            Const.LOADIG(context);
            Timer(Duration(seconds: 2),(){
              Get.to(()=>HomeView());

            });
          },
          child: Icon(Icons.done,size: 5.w,),
        ),
      ),
      body: MyOrdersViewBody(),
    );
  }
}
