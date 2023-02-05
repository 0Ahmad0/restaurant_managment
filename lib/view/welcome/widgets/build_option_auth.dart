import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/login/login_view.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';

import '../../../model/utils/sizer.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/values_manager.dart';

Widget buildOptionAuthApp(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p40, vertical: AppPadding.p40),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s50),
        )),
    child: Column(
      children: [
        ButtonApp(
          text: tr(
            LocaleKeys.waitr,
          ),
          onPressed: () {
            Get.to(() => LoginView(
                  typeUser: AppConstants.collectionUser,
                ));
          },
          color: Theme.of(context).cardColor,
          textColor: Theme.of(context).textTheme.subtitle1!.color,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ButtonApp(
          text: tr(LocaleKeys.chef),
          onPressed: () {
            Get.to(() => LoginView(
                  typeUser: AppConstants.collectionChef,
                ));
          },
          color: Theme.of(context).cardColor,
          textColor: Theme.of(context).textTheme.subtitle1!.color,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        ButtonApp(
          text: tr(LocaleKeys.supervisor),
          onPressed: () {
            Get.to(() => LoginView(
                  typeUser: AppConstants.collectionAdmin,
                ));
          },
          color: Theme.of(context).cardColor,
          textColor: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ],
    ),
  );
}
