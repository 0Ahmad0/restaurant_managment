import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';
import 'package:restaurant_managment/model/utils/local/storage.dart';
import 'package:restaurant_managment/view/welcome/welcome_view.dart';

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
  const MenuScreen({Key? key, required this.profileProvider}) : super(key: key);
  final ProfileProvider profileProvider;
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          ChangeNotifierProvider<ProfileProvider>.value(
              value: Provider.of<ProfileProvider>(context),
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) =>
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor
                      ),
                      margin: EdgeInsets.zero,
                      accountName: Text(
                        value.user.name,
                        style: getRegularStyle(
                            color: Theme.of(context).textTheme.subtitle1!.color,
                            fontSize: 10.sp
                        ),
                      ),
                      accountEmail: Text(
                        value.user.email,
                        style: getLightStyle(
                            color: Theme.of(context).textTheme.subtitle1!.color,
                            fontSize: 8.sp
                        ),
                      ),
                      currentAccountPicture:
                      Container(
                          decoration: BoxDecoration(

                            color: Theme.of(context).primaryColor,
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
                    widt0h: Sizer.getW(context) * 0.12,
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
          if(!widget.profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))
          CustomListTile(
            onTap: (){
              Get.to(()=>ConfirmOrderView());
            },
            title: tr(LocaleKeys.order_status),
          ),
          if(!widget.profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))
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
          if(widget.profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))
          CustomListTile(
            onTap: (){
              Get.to(()=>AddChefView());
            },
            icon: Icons.add,
            title: tr(LocaleKeys.add_chef),
          ),
          if(widget.profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))
          const Divider(
            thickness: 1.5,
          ),
          if(widget.profileProvider.user.typeUser.contains(AppConstants.collectionChef))
          CustomListTile(
            onTap: (){
              Get.to(()=>AddMealView());
            },
            icon: Icons.restaurant_menu,
            title: tr(LocaleKeys.add_meal),
          ),
          if(widget.profileProvider.user.typeUser.contains(AppConstants.collectionChef))
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
             AppStorage.depose();
             Get.to(()=>WelcomeView());
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