import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/order_provider.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';
import 'package:sizer/sizer.dart';

import '../../../model/models.dart';
import '../../../model/utils/consts_manager.dart';
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
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
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
                double priceOrder=(double.parse(orderProvider.orders.orders.values.elementAt(index).meal!.price)*orderProvider.orders.orders.values.elementAt(index).count);
                orderProvider.orders.totalPrice='${double.parse(orderProvider.orders.totalPrice)-priceOrder}';
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
            tr(LocaleKeys.number_of_dishes) + " : ${orderProvider.orders.orders.values.elementAt(index).count}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_table)} : ${orderProvider.orders.orderTable}",
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


class BuildMyOrder extends StatelessWidget {

  final int index;
  final bool isOk;


  BuildMyOrder(
  {super.key,
  required this.index,
  this.isOk = true
  });

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider= Provider.of<OrderProvider>(context);
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    return ShadowContainer(
      padding:  AppPadding.p10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${tr(LocaleKeys.order_id)} : ${orderProvider.listOrdersCurrent.listOrders[index].orderId}",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
              if(isOk)IconButton(onPressed: () async {
                if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
                  await orderProvider.deleteOrder(context, orders: orderProvider.listOrdersCurrent.listOrders[index]);
                else
                  {
                  orderProvider.listOrdersCurrent.listOrders[index].status=StateOrder.rejected.name;
                  await orderProvider.updateOrder(context, orders:  orderProvider.listOrdersCurrent.listOrders[index]);
                  }

                    orderProvider.notifyListeners();
              }, icon: Icon(Icons.delete,
                size: 20.sp,
                color: ColorManager.error,
              )),
            ],
          ),
          // nameOrder == null?SizedBox():Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     const SizedBox(
          //       height: AppSize.s20,
          //     ),
          //     Text(
          //       "${nameOrder}",
          //       style: getBoldStyle(color: ColorManager.primaryColor, fontSize: 14.sp),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            tr(LocaleKeys.number_of_dishes) + " : ${orderProvider.listOrdersCurrent.listOrders[index].orders.length}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_table)} : ${orderProvider.listOrdersCurrent.listOrders[index].orderTable}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_time)} : ${DateFormat.yMEd().add_jm().format(orderProvider.listOrdersCurrent.listOrders[index].orderTime)}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: orderProvider.listOrdersCurrent.listOrders[index].orderNotes),
           ),
        ],
      ),
    );
  }
}
class BuildMyOrderExpired extends StatelessWidget {

  final int index;
  final bool isOk;


  BuildMyOrderExpired(
  {super.key,
  required this.index,
  this.isOk = true
  });

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider= Provider.of<OrderProvider>(context);
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    return ShadowContainer(
      padding:  AppPadding.p10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${tr(LocaleKeys.order_id)} : ${orderProvider.listOrdersExpired.listOrders[index].orderId}",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
              if(isOk)IconButton(onPressed: () async {
                if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
                  await orderProvider.deleteOrder(context, orders: orderProvider.listOrdersExpired.listOrders[index]);
                else
                  {
                  orderProvider.listOrdersExpired.listOrders[index].status=StateOrder.rejected.name;
                  await orderProvider.updateOrder(context, orders:  orderProvider.listOrdersExpired.listOrders[index]);
                  }

                    orderProvider.notifyListeners();
              }, icon: Icon(Icons.delete,
                size: 20.sp,
                color: ColorManager.error,
              )),
            ],
          ),
          // nameOrder == null?SizedBox():Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     const SizedBox(
          //       height: AppSize.s20,
          //     ),
          //     Text(
          //       "${nameOrder}",
          //       style: getBoldStyle(color: ColorManager.primaryColor, fontSize: 14.sp),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            tr(LocaleKeys.number_of_dishes) + " : ${orderProvider.listOrdersExpired.listOrders[index].orders.length}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_table)} : ${orderProvider.listOrdersExpired.listOrders[index].orderTable}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_time)} : ${DateFormat.yMEd().add_jm().format(orderProvider.listOrdersExpired.listOrders[index].orderTime)}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: orderProvider.listOrdersExpired.listOrders[index].orderNotes),
           ),
        ],
      ),
    );
  }
}
class BuildMyOrderItem2 extends StatelessWidget {

  final int index;
  final Order order;
  final bool isOk;
  final String orderTable;


  BuildMyOrderItem2(
  {super.key,
  required this.index,
  required this.orderTable,
  this.isOk = true, required this.order
  });

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider= Provider.of<OrderProvider>(context);
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    return ShadowContainer(
      padding:  AppPadding.p10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${tr(LocaleKeys.order_id)} : ${order.orderId}",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),

            ],
          ),
          // nameOrder == null?SizedBox():Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     const SizedBox(
          //       height: AppSize.s20,
          //     ),
          //     Text(
          //       "${nameOrder}",
          //       style: getBoldStyle(color: ColorManager.primaryColor, fontSize: 14.sp),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            tr(LocaleKeys.number_of_dishes) + " : ${order.count}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_table)} : ${orderTable}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            "${tr(LocaleKeys.order_time)} : ${order.orderTime}",
            style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: order.orderNotes),
           ),
        ],
      ),
    );
  }
}
