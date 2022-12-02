import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';

import 'widgets/confirm_order_view_body.dart';

class ConfirmOrderView extends StatelessWidget {
  const ConfirmOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> typeOrders = [
      tr(LocaleKeys.current_orders),
      tr(LocaleKeys.expired_orders),
    ];
    return DefaultTabController(
      length: typeOrders.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.order_status)),
          bottom: TabBar(
            indicatorColor: ColorManager.black,

            tabs: [
             for(int i = 0 ; i < typeOrders.length ; i++)
               Tab(
                 text: typeOrders[i],
               )
            ],
          ),
        ),

        body: ConfirmOrderViewBody(),
      ),
    );
  }
}
