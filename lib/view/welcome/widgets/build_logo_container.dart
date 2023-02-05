import 'package:flutter/material.dart';

import '../../../model/utils/sizer.dart';
import '../../resourse/assets_manager.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';
Widget buildContainerLogo(BuildContext context) {
  return Container(
    width: SizerApp.getW(context) / 2,
    height: SizerApp.getW(context) / 2,
    padding: const EdgeInsets.all(AppPadding.p8),
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSize.s50),
        image: DecorationImage(
            image: AssetImage(AssetsManager.splashLogoIMG)
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(.5),
            blurRadius: AppSize.s10,
          )
        ]
    ),
  );
}
