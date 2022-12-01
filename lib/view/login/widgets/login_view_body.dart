import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/utils/const.dart';
import '/translations/locale_keys.g.dart';
import '/view/home/home_view.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import '/view/resourse/values_manager.dart';
import '/view/signup/signup_view.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/textformfiled_app.dart';
import '../../manager/widgets/ShadowContainer.dart';

class LoginViewBody extends StatelessWidget {
  final keyForm = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: AppPadding.p50,
      margin: 0.0,
      child: SafeArea(
        child: Form(
          key: keyForm,
          child: ShadowContainer(
            padding: AppPadding.p40,
            child: ListView(
              children: [
            //     ButtonApp(text: "Hello", onPressed: (){
            //
            //      context.setLocale(Locale('ar'));
            //      Get.updateLocale(Locale('ar'));
            //
            // }),
                Text(
                  tr(LocaleKeys.login),
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16.sp),
                ),
                CircleAvatar(
                  radius: 40.sp,
                  backgroundColor: ColorManager.white,
                  child: Image.asset(AssetsManager.splashLogoIMG),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: idController,
                    hintText: tr(LocaleKeys.mobile_number) + '  |  '+tr(LocaleKeys.email_address),
                    iconData: Icons.person,
                  ),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: passwordController,
                    validator: (val){
                      //TOOD Make Password is Strong
                      if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                      if(val.length < 8) return tr(LocaleKeys.enter_strong_password);
                      return null;
                    },
                    hintText: tr(LocaleKeys.password),
                    iconData: Icons.lock,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                ),
                 SizedBox(
                  height: 5.h,
                ),
                FadeInDownBig(
                  child: ButtonApp(
                      text: tr(LocaleKeys.login),
                      textColor: ColorManager.white,
                      onPressed: () {
                        if(keyForm.currentState!.validate()){
                          Const.LOADIG(context);
                          FocusManager.instance.primaryFocus!.unfocus();
                          Get.to(()=>HomeView(),transition: Transition.circularReveal);
                        }else{
                          Get.snackbar("Error", "Please fill all");
                        }
                      },
                  ),
                ),
                FadeInRightBig(
                  child: TextButton(
                    onPressed: (){
                      Get.off(()=>SignupView(),transition: Transition.leftToRightWithFade);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr(
                          LocaleKeys.new_member,),
                          style: getRegularStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 10.sp,

                          ),

                        ),
                        Text(tr(
                          LocaleKeys.signup,),
                          style: getRegularStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 10.sp
                          ).copyWith(
                              decoration: TextDecoration.underline

                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
