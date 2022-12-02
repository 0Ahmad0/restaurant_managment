import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import 'build_my_order_item.dart';

class MyOrdersViewBody extends StatelessWidget {
  const MyOrdersViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(
            bottom: AppPadding.p40
          ),
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
        ),
        Container(
          color: ColorManager.primaryColor,
          child: ButtonApp(
              text: tr(LocaleKeys.total_amount) +
                  ' : ${153.5}' +
                  tr(LocaleKeys.sr),
              onPressed: null),
        )
      ],
    );
  }
}
