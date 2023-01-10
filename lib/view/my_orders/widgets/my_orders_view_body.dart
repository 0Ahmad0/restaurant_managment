import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/utils/function_helper_view_provider.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/order_provider.dart';
import 'build_my_order_item.dart';

class MyOrdersViewBody extends StatelessWidget {
  const MyOrdersViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<OrderProvider>.value(
        value: Provider.of<OrderProvider>(context),
        child: Consumer<OrderProvider>(
            builder: (context, value, child) =>
      Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(
            bottom: AppPadding.p40
          ),
          itemCount: value.orders.orders.length,
          itemBuilder: (ctx, index) {
            return BuildMyOrderItem(
              index: index,
              numberOrder: '${value.orders.orders.values.elementAt(index).orderId}',
              tableOrder: '${value.orders.orders.values.length} A',
              timeOrder: DateTime.now(),
              notesOrder: '${value.orders.orders.values.elementAt(index).orderNotes}',//'بدون ماينوز وكثر الحد',
              nameOrder: "${FunctionHelperViewProvider.chooseNameByLanguage(ar: value.orders.orders.values.elementAt(index).meal?.mealNameAr, en: value.orders.orders.values.elementAt(index).meal?.mealNameEn)}",
            );
          },
        ),
        Container(
          color: ColorManager.primaryColor,
          child: ButtonApp(
              text: tr(LocaleKeys.total_amount) +
                  ' : ${value.orders.totalPrice}' +
                  tr(LocaleKeys.sr),
              onPressed: null),
        )
      ],
    )));
  }
}
