import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/ShadowContainer.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/manager/widgets/textformfiled_app.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class AddChefViewBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ShadowContainer(

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                  AppPadding.p40),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsManager.addChefIMG,
                    height: 30.h,
                    width: 30.w,
                  ),
                  TextFiledApp(
                    iconData: Icons.person,
                    hintText: tr(LocaleKeys.full_name),
                  ),
                  TextFiledApp(
                    iconData: Icons.email,
                    hintText: tr(LocaleKeys.email_address),
                  ),
                  TextFiledApp(
                    iconData: Icons.lock,
                    obscureText: true,
                    suffixIcon: true,
                    hintText: tr(LocaleKeys.password),
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  ButtonApp(
                    text: tr(LocaleKeys.done),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
