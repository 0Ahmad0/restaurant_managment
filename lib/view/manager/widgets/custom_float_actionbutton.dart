import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../const.dart';

class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>ConstApp.showModalBottomSheetCart(context),
      child: Stack(
        children: [
          Container(
            height: 15.h,
            width: 15.w,
            child: FittedBox(
              child: FloatingActionButton(onPressed: ()=>ConstApp.showModalBottomSheetCart(context),
                child:                   Icon(Icons.shopping_cart_sharp),
              ),
            ),
          ),
          Positioned(
              top: 3.5.h,
              right: 1.5.w,
              child: CircleAvatar(
                backgroundColor: ColorManager.secondaryColor,
                radius: 7.5.sp,
                child: Text("${ConstApp.myOrder.length}",
                  textAlign: TextAlign.center,
                  style: getBoldStyle(color: ColorManager.white,
                    fontSize: 10.sp,),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      ),
    );
  }
}
