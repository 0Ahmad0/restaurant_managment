import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../translations/locale_keys.g.dart';
import '../../manager/widgets/button_app.dart';
import '../../my_orders/widgets/build_my_order_item.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';

class ShowOrderDetailsViewBody extends StatelessWidget {
  const ShowOrderDetailsViewBody({Key? key}) : super(key: key);

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
