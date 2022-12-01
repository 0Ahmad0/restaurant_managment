import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'build_my_order_item.dart';

class MyOrdersViewBody extends StatelessWidget {
  const MyOrdersViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return BuildMyOrderItem(
          numberOrder: '${index + 1}',
          tableOrder: '$index A',
          timeOrder: DateTime.now(),
          notesOrder: 'بدون ماينوز وكثر الحد',
          nameOrder: "بطاطا حارة",
        );
      },
    );
  }
}

