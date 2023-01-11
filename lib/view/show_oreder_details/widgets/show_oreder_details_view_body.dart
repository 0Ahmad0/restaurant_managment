import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../model/models.dart';
import '../../../translations/locale_keys.g.dart';
import '../../manager/widgets/button_app.dart';
import '../../my_orders/widgets/build_my_order_item.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';

class ShowOrderDetailsViewBody extends StatelessWidget {
  const ShowOrderDetailsViewBody({Key? key, required this.orders, required this.index}) : super(key: key);
  final Orders orders;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(
              bottom: AppPadding.p40
          ),
          itemCount: orders.orders.length,
          itemBuilder: (ctx, index1) {
            return BuildMyOrderItem2(
              index: index, order: orders.orders.values.elementAt(index1),orderTable:orders.orderTable
             
            );
          },
        ),
        Container(
          color: ColorManager.primaryColor,
          child: ButtonApp(
              text: tr(LocaleKeys.total_amount) +
                  ' : ${double.parse(orders.totalPrice).toStringAsFixed(2)}' +
                  tr(LocaleKeys.sr),
              onPressed: null),
        )
      ],
    );
  }
}
