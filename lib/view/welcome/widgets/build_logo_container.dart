import 'package:flutter/material.dart';

import '../../../model/utils/sizer.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';
Widget buildContainerLogo(BuildContext context) {
  return Container(
    width: Sizer.getW(context) / 2,
    height: Sizer.getW(context) / 2,
    padding: const EdgeInsets.all(AppPadding.p8),
    decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s50),
        image: DecorationImage(
            image: AssetImage(AssetsManager.splashLogoIMG)
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.lightGray.withOpacity(.5),
            blurRadius: AppSize.s10,
          )
        ]
    ),
  );
}
