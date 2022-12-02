import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../translations/locale_keys.g.dart';
import '../../manager/widgets/ShadowContainer.dart';
import '../../manager/widgets/textformfiled_app.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class BuildMyOrderItem extends StatelessWidget {
  final String numberOrder;
  final String tableOrder;
  final DateTime timeOrder;
  final String? notesOrder;
  final String? nameOrder;
  final bool isOk;


   BuildMyOrderItem(
      {super.key,
        required this.numberOrder,
        required this.tableOrder,
        required this.timeOrder,
        this.notesOrder = "",
        this.nameOrder,
        this.isOk = true
      });

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding:  AppPadding.p10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${tr(LocaleKeys.order_id)} : ${numberOrder}",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
              if(isOk)IconButton(onPressed: () {}, icon: Icon(Icons.delete,
                size: 20.sp,
                color: ColorManager.error,
              )),
            ],
          ),
          nameOrder == null?SizedBox():Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSize.s20,
              ),
              Text(
                "${nameOrder}",
                style: getBoldStyle(color: ColorManager.primaryColor, fontSize: 14.sp),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_table)} : ${tableOrder}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_time)} : ${DateFormat.yMEd().add_jm().format(timeOrder)}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          TextFiledApp(
              controller: TextEditingController(text: notesOrder),
              iconData: Icons.edit,
              hintText: tr(LocaleKeys.order_notes))
        ],
      ),
    );
  }
}
