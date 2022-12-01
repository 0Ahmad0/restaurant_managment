import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/view/confirms_order/confirm_order_view.dart';
import 'package:restaurant_managment/view/profile/profile_view.dart';
import 'package:sizer/sizer.dart';

import '../../../model/utils/sizer.dart';
import '../../../translations/locale_keys.g.dart';
import '../../manager/widgets/custom_listtile.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';

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
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: ColorManager.white
            ),
            margin: EdgeInsets.zero,
            accountName: Text(
               tr(LocaleKeys.full_name),
              style: getRegularStyle(
                  color: ColorManager.black,
                  fontSize: 10.sp
                  ),
            ),
            accountEmail: Text(
              tr(LocaleKeys.email_address),
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
                  child: FlutterLogo()
              ),
         ),
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
              Get.back();
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
              Get.back();
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
            exit(0);
           },
           icon: Icons.logout,
           title: tr(LocaleKeys.exit),
         ),

        ],
      ),
    );
  }
}