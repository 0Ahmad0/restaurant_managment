import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '/model/utils/const.dart';
import '/translations/locale_keys.g.dart';
import '/view/login/login_view.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/textformfiled_app.dart';
import '../../manager/widgets/ShadowContainer.dart';

class SignupViewBody extends StatelessWidget {
   SignupViewBody({Key? key}) : super(key: key);
  final keyForm = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final idController = TextEditingController();

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
                Text(
                  tr(LocaleKeys.signup),
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16.sp),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: fullNameController,
                    hintText: tr(LocaleKeys.full_name),
                    iconData: Icons.person,
                  ),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    keyboardType: TextInputType.phone,
                    controller: mobileNumberController,
                    validator: (val){
                      if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                      if(!val.isPhoneNumber) return tr(LocaleKeys.enter_valid_phone_number);
                      return null;
                    },
                    hintText: tr(LocaleKeys.mobile_number),
                    iconData: Icons.phone_iphone,
                  ),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailAddressController,
                    validator: (val){
                      if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                      if(!val.isEmail) return tr(LocaleKeys.enter_valid_email);
                      return null;
                    },
                    hintText: tr(LocaleKeys.email_address),
                    iconData: Icons.email,
                  ),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: passwordController,
                    validator: (val){
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
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: confirmPasswordController,
                    validator: (val){
                      if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                      if(confirmPasswordController.text.compareTo(passwordController.text)!=0) return tr(LocaleKeys.enter_matched_password);
                      return null;
                    },
                    hintText: tr(LocaleKeys.confirm_password),
                    iconData: Icons.lock,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                ),
                // FadeInDownBig(
                //   child: TextFiledApp(
                //     controller: idController,
                //     validator: (val){
                //       if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                //       if(val != "nick") return tr(LocaleKeys.this_id_is_already_in_use);
                //       return null;
                //     },
                //     hintText: tr(LocaleKeys.id),
                //     iconData: Icons.numbers,
                //   ),
                // ),
                // SizedBox(
                //   height: 5.h,
                // ),
                FadeInDownBig(
                  child: ButtonApp(
                    text: tr(LocaleKeys.signup),
                    textColor: ColorManager.white,
                    onPressed: () {
                      if(keyForm.currentState!.validate()){
                        Const.LOADIG(context);
                      }else{
                        Get.snackbar("Error", "Please fill all");
                      }
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                  ),
                ),
                FadeInRightBig(
                  child: TextButton(
                    onPressed: (){
                      Get.off(()=>LoginView(),
                          transition: Transition.rightToLeftWithFade);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr(
                          LocaleKeys.already_have_account,),
                          style: getRegularStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 10.sp,

                          ),

                        ),
                        Text(tr(
                          LocaleKeys.login,),
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
