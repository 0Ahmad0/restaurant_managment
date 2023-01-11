import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/order_provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/my_orders/widgets/build_my_order_item.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/profile_provider.dart';
import '../../../model/utils/const.dart';
import '../../../model/utils/consts_manager.dart';

class ConfirmOrderViewBody extends StatefulWidget {
  const ConfirmOrderViewBody({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderViewBody> createState() => _ConfirmOrderViewBodyState();
}

class _ConfirmOrderViewBodyState extends State<ConfirmOrderViewBody> {
  var getListOrderCurrent;
  var getListOrderExpired;
  late ProfileProvider profileProvider;
  late OrderProvider orderProvider;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getListOrderCurrentFun();
    getListOrderExpiredFun();
    super.initState();
  }
  getListOrderCurrentFun() async {

    if(profileProvider.user.typeUser.contains(AppConstants.collectionUser)){
      getListOrderCurrent = FirebaseFirestore.instance
          .collection(AppConstants.collectionOrder)
          .where("idUser",isEqualTo:profileProvider.user.id )
      .where("status",isEqualTo: StateOrder.current.name)
          .snapshots();
    }

    else if(profileProvider.user.typeUser.contains(AppConstants.collectionChef)){
      getListOrderCurrent = FirebaseFirestore.instance
          .collection(AppConstants.collectionOrder)
          .where("status",isEqualTo: StateOrder.current.name)
          .snapshots();
    }

    return getListOrderCurrent;
  }
  getListOrderExpiredFun() async {

    if(profileProvider.user.typeUser.contains(AppConstants.collectionUser)){
      getListOrderExpired = FirebaseFirestore.instance
          .collection(AppConstants.collectionOrder)
          .where("idUser",isEqualTo:profileProvider.user.id )
          .where("status",isEqualTo: StateOrder.expired.name)
          .snapshots();
    }

    else if(profileProvider.user.typeUser.contains(AppConstants.collectionChef)){
      getListOrderExpired = FirebaseFirestore.instance
          .collection(AppConstants.collectionOrder)
          .where("status",isEqualTo: StateOrder.expired.name)
          .snapshots();
    }

    return getListOrderExpired;
  }
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    orderProvider = Provider.of<OrderProvider>(context);
    return TabBarView(
      children: [
        StreamBuilder<QuerySnapshot>(
          //prints the messages to the screen0
            stream: getListOrderCurrent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  (orderProvider.listOrdersCurrent.listOrders.length>0)?
                 buildOrderCurrent(context)
                  :Const.SHOWLOADINGINDECATOR();

              }
              else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();
                  print( 'list Orders Current : ${orderProvider.listOrdersCurrent.listOrders.length}');
                  return buildOrderCurrent(context);
                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
        /*------------------------------------*/
        StreamBuilder<QuerySnapshot>(
          //prints the messages to the screen0
            stream: getListOrderExpired,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  (orderProvider.listOrdersExpired.listOrders.length>0)?
                  buildOrderExpired(context)
                      :Const.SHOWLOADINGINDECATOR();

              }
              else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();
                  print( 'list Orders Expired : ${orderProvider.listOrdersExpired.listOrders.length}');
                  return buildOrderExpired(context);
                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ],
    );
  }
  buildOrderCurrent(context){
    return ListView.builder(
      itemCount: orderProvider.listOrdersCurrent.listOrders.length,
      itemBuilder: (context, index) {
        orderProvider.orders = orderProvider.listOrdersCurrent.listOrders[index];
        return Stack(
        children: [
          BuildMyOrderItem(
              index: index,
              numberOrder: '${orderProvider.listOrdersCurrent.listOrders[index].orderId}',
              tableOrder: '${index} 15AF',
              timeOrder: orderProvider.listOrdersCurrent.listOrders[index].orderTime),
          if(profileProvider.user.typeUser.contains(AppConstants.collectionChef))Positioned(
            left: 10.sp,
            bottom: 10.sp,
            child: GestureDetector(
              onTap: () {
                print(index);
              },
              child: CircleAvatar(
                radius: 15.sp,
                child: Icon(
                  Icons.done,
                  size: 12.sp,
                ),
              ),
            ),
          )
        ],
      );}
    );
  }
  buildOrderExpired(context){
    return ListView.builder(
      itemCount: orderProvider.listOrdersExpired.listOrders.length,
      itemBuilder: (context, index) => Stack(
        children: [
          BuildMyOrderItem(
            index: index,
            isOk: false,
            numberOrder: '${orderProvider.listOrdersExpired.listOrders[index].orderId}',
            tableOrder: '${index} 15AF',
            timeOrder:orderProvider.listOrdersExpired.listOrders[index].orderTime,
            nameOrder: '${index * 12 + 9 / 96} APODKj',
          ),
          Positioned(
              left: 15.sp,
              bottom: 0.sp,
              child: Transform.rotate(
                angle: -35,
                child: Container(
                  alignment: Alignment.center,
                  width: 8.w,
                  height: 20.h,
                  color: ColorManager.success,
                  child: Transform.rotate(
                      angle: -1.7,
                      child: Text(
                        tr(LocaleKeys.done),
                        style: getRegularStyle(
                            color: ColorManager.white,
                            fontSize: 14.sp
                        ),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
