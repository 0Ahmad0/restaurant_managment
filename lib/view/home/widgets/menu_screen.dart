import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin/add_meal/add_meal_view.dart';
import '/view/confirms_order/confirm_order_view.dart';
import '/view/profile/profile_view.dart';
import '/view/setting/setting_view.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/view/confirms_order/confirm_order_view.dart';
import 'package:restaurant_managment/view/login/login_view.dart';
import 'package:restaurant_managment/view/profile/profile_view.dart';
import 'package:restaurant_managment/view/setting/setting_view.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/profile_provider.dart';
import '../../../model/utils/sizer.dart';
import '../../../translations/locale_keys.g.dart';
import '../../admin/add_chef/add_chef_view.dart';
import '../../app/picture/cach_picture_widget.dart';
import '../../app/picture/profile_picture_widget.dart';
import '../../manager/widgets/custom_listtile.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Column(
        children: [
          ChangeNotifierProvider<ProfileProvider>.value(
              value: Provider.of<ProfileProvider>(context),
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) =>
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: ColorManager.white
                      ),
                      margin: EdgeInsets.zero,
                      accountName: Text(
                        value.user.name,
                        style: getRegularStyle(
                            color: ColorManager.black,
                            fontSize: 10.sp
                        ),
                      ),
                      accountEmail: Text(
                        value.user.email,
                        style: getLightStyle(
                            color: ColorManager.black,
                            fontSize: 8.sp
                        ),
                      ),
                      currentAccountPicture:
                      Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child:ClipOval(
                              child:
                              CacheNetworkImage(
                                  photoUrl: '${value.user.photoUrl}',
                                  width: SizerApp.getW(context) * 0.12,
                                  height:SizerApp.getW(context) * 0.12,
                                  waitWidget: WidgetProfilePicture(
                                    name: value.user.name,
                                    radius: AppSize.s30,
                                    fontSize: SizerApp.getW(context) / 16,
                                  ),
                                  errorWidget: WidgetProfilePicture(
                                    name: value.user.name,
                                    radius: AppSize.s30,
                                    fontSize: SizerApp.getW(context) / 16,
                                  ))
                          )
                      ),
                    ),
              )),
          /*
                //TODO Add Code
                ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: Sizer.getW(context) * 0.12,
                    height: Sizer.getW(context) * 0.12,
                    imageUrl:
                    // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                    "${value.user.photoUrl}",
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                )
                */
          CustomListTile(
            onTap: (){
              Get.to(()=>ConfirmOrderView());
            },
            icon: Icons.star_rate_outlined,
            title: tr(LocaleKeys.evaluate_the_service),
          ),
          const Divider(
            thickness: 1.5,
          ),
          CustomListTile(
            onTap: (){
              Get.to(()=>ProfileView());
            },
            icon: Icons.person_pin,
            title: tr(LocaleKeys.update_information),
          ),
          const Divider(
            thickness: 1.5,
          ),
          CustomListTile(
            onTap: (){
              Get.to(()=>AddChefView());
            },
            icon: Icons.add,
            title: tr(LocaleKeys.add_chef),
          ),
          const Divider(
            thickness: 1.5,
          ),
          CustomListTile(
            onTap: (){
              Get.to(()=>AddMealView());
            },
            icon: Icons.restaurant_menu,
            title: tr(LocaleKeys.add_meal),
          ),
          const Divider(
            thickness: 1.5,
          ),
          CustomListTile(
            onTap: (){
              Get.to(()=>SettingView());
            },
            icon: Icons.settings,
            title: tr(LocaleKeys.setting),
          ),
          const Divider(
            thickness: 1.5,
          ),
         CustomListTile(
           onTap: (){
             Get.to(()=>LoginView());
          //  exit(0);
           },
           icon: Icons.logout,
           title: tr(LocaleKeys.exit),
         ),

        ],
      ),
    );
  }
}