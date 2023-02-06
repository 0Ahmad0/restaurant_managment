import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';
import 'package:restaurant_managment/model/models.dart';

import '../../../controller/meal_provider.dart';
import '../../../model/utils/consts_manager.dart';
import '../../admin/show_accounts/show_accounts_view.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';
import 'main_screen.dart';
import 'menu_screen.dart';

class HomeViewBody extends StatelessWidget {
   HomeViewBody({Key? key, required this.profileProvider}) : super(key: key);
  final zoomController = ZoomDrawerController();
final ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    MealProvider mealProvider= Provider.of<MealProvider>(context);
    return ZoomDrawer(

      isRtl: context.locale == Locale('ar')?true:false,
      menuBackgroundColor: Theme.of(context).primaryColor,
      controller: zoomController,
      menuScreen:  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?SizedBox():MenuScreen(profileProvider:profileProvider),
      mainScreen:  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
          MenuScreen(profileProvider: profileProvider)
          :MainScreen(mealProvider:mealProvider),
      borderRadius: AppSize.s24,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.white,
      slideWidth: MediaQuery.of(context).size.width /1.7,
      angle: -AppSize.s10,
    );
  }
}
