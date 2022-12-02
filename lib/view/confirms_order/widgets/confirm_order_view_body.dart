import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/my_orders/widgets/build_my_order_item.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrderViewBody extends StatelessWidget {
  const ConfirmOrderViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Stack(
            children: [
              BuildMyOrderItem(
                  numberOrder: '${index + 2}',
                  tableOrder: '${index} 15AF',
                  timeOrder: DateTime.now()),
              Positioned(
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
          ),
        ),
        /*------------------------------------*/
        ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Stack(
            children: [
              BuildMyOrderItem(
                isOk: false,
                numberOrder: '${index + 2}',
                tableOrder: '${index} 15AF',
                timeOrder: DateTime.now(),
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
        ),
      ],
    );
  }
}
