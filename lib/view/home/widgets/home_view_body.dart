import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';
import 'main_screen.dart';
import 'menu_screen.dart';

class HomeViewBody extends StatelessWidget {
   HomeViewBody({Key? key}) : super(key: key);
  final zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: ColorManager.primaryColor,
      controller: zoomController,
      menuScreen:  MenuScreen(),
      mainScreen:  MainScreen(),
      borderRadius: AppSize.s24,
      showShadow: true,
      isRtl: context.locale != 'ar'?true:false,
      drawerShadowsBackgroundColor: Colors.white,
      slideWidth: MediaQuery.of(context).size.width /1.75,
    );
  }
}
