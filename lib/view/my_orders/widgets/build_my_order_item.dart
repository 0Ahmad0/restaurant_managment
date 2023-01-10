import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/order_provider.dart';
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
  final int index;
  final bool isOk;


   BuildMyOrderItem(
      {super.key,
        required this.numberOrder,
        required this.index,
        required this.tableOrder,
        required this.timeOrder,
        this.notesOrder = "",
        this.nameOrder,
        this.isOk = true
      });

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider= Provider.of<OrderProvider>(context);
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
              if(isOk)IconButton(onPressed: () {
                int priceOrder=(int.parse(orderProvider.orders.orders.values.elementAt(index).meal!.price)*orderProvider.orders.orders.values.elementAt(index).count);
                orderProvider.orders.totalPrice='${int.parse(orderProvider.orders.totalPrice)-priceOrder}';
                orderProvider.orders.orders.remove(orderProvider.orders.orders.keys.elementAt(index));
                orderProvider.notifyListeners();
              }, icon: Icon(Icons.delete,
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
              hintText: tr(LocaleKeys.order_notes)
          ,onChanged: (value){
                orderProvider.orders.orders.values.elementAt(index).orderNotes=value;
          },),
        ],
      ),
    );
  }
}
