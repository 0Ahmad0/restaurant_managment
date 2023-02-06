import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/order_provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/my_orders/widgets/build_my_order_item.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:restaurant_managment/view/show_oreder_details/show_oreder_details_view.dart';
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
    .where("status",whereIn: [StateOrder.expired.name,StateOrder.rejected.name])
          .snapshots();

    }

    else if(profileProvider.user.typeUser.contains(AppConstants.collectionChef)){
      getListOrderExpired = FirebaseFirestore.instance
          .collection(AppConstants.collectionOrder)
          .where("status",whereIn: [StateOrder.expired.name,StateOrder.rejected.name])
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
                  orderProvider.listOrdersCurrent=ListOrders.fromJson(snapshot.data!.docs);
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
                  orderProvider.listOrdersExpired=ListOrders.fromJson(snapshot.data!.docs);
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
        return Stack(
        children: [
          InkWell(
            onTap: ()=>Get.to(()=>ShowOrderDetailsView(
                index:index,
               orders: orderProvider.listOrdersCurrent.listOrders[index]
            )),
            child: BuildMyOrder(
              index: index,
              isOk: true,
            ),
          ),
          if(profileProvider.user.typeUser.contains(AppConstants.collectionChef))Positioned(
            left: 10.sp,
            bottom: 10.sp,
            child: GestureDetector(
              onTap: () async {
                orderProvider.listOrdersCurrent.listOrders[index].status=StateOrder.expired.name;
                await orderProvider.updateOrder(context, orders:  orderProvider.listOrdersCurrent.listOrders[index]);
                orderProvider.notifyListeners();
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
          InkWell(
            onTap: ()=>Get.to(()=>ShowOrderDetailsView(
              index:index,
              orders: orderProvider.listOrdersExpired.listOrders[index],
            )),
            child: BuildMyOrderExpired(
              index: index,
              isOk: false,
            ),
          ),
          Positioned(
              left: context.locale == Locale('en')?null: 15.sp,
              right: context.locale == Locale('ar')?null: 15.sp,
              top: 0.sp,
              child: Container(
                alignment: Alignment.center,
                width: 12.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color:(orderProvider.listOrdersExpired.listOrders[index].status.contains(StateOrder.rejected.name))?ColorManager.error: ColorManager.success,
                  shape: BoxShape.circle
                ),
                child: Text(
    (orderProvider.listOrdersExpired.listOrders[index].status.contains(StateOrder.rejected.name))?
       tr(LocaleKeys.rejected)
                  :tr(LocaleKeys.done),
                  style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: 12.sp
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
