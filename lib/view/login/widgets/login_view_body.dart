import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/controller/utils/create_environment_provider.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';
import '../../../controller/auth_provider.dart';
import '../../../model/models.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthProvider authProvider;
 
  final String typeUser;
  LoginViewBody({required this.authProvider, required this.typeUser});
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).primaryColor,
      padding: AppPadding.p50,
      margin: 0.0,
      child: SafeArea(
        child: Form(
          key: keyForm,
          child: ShadowContainer(
            color: Theme.of(context).cardColor,
            shadowColor: Theme.of(context).primaryColor,
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
                      color: ColorManager.primaryColor, fontSize: 16.sp),
                ),
                CircleAvatar(
                  radius: 40.sp,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Image.asset(AssetsManager.splashLogoIMG),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: idController,
                    hintText: tr(LocaleKeys.mobile_number) +
                        '  |  ' +
                        tr(LocaleKeys.email_address),
                    iconData: Icons.person,
                  ),
                ),
                FadeInDownBig(
                  child: TextFiledApp(
                    controller: passwordController,
                    validator: (val) {
                      //TOOD Make Password is Strong
                      if (val!.trim().isEmpty)
                        return tr(LocaleKeys.field_required);
                      if (val.length < 8)
                        return tr(LocaleKeys.enter_strong_password);
                      return null;
                    },
                    hintText: tr(LocaleKeys.password),
                    iconData: Icons.lock,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                ),
                const SizedBox(height: AppSize.s20,),
                FadeInDownBig(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.dialog(
                              Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.all(AppPadding.p20),
                                    margin: EdgeInsets.all(AppMargin.m20),
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(AppSize.s24)
                                    ),
                                    child: Column(
                                      children: [
                                        TextFiledApp(
                                          controller:emailController ,
                                            iconData: Icons.email,
                                            hintText: tr(LocaleKeys.recovery_email)
                                        ),
                                        Spacer(),
                                        ButtonApp(text: tr(LocaleKeys.done),
                                            onPressed: () async {
                                              Const.LOADIG(context);
                                              final result =await authProvider.sendPasswordResetEmail(context, resetEmail: emailController.text);
                                              Navigator.of(context).pop();
                                              if(result['status']){
                                                Get.back();
                                              }

                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            );
                          },
                          child: Text(
                            tr(LocaleKeys.forget_password),
                            style:
                                getRegularStyle(
                                    color: ColorManager.primaryColor,
                                  fontSize: 15.sp
                                ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s20,),

                FadeInDownBig(
                  child: ButtonApp(
                    text: tr(LocaleKeys.login),
                    textColor: ColorManager.white,
                    onPressed: () async {
                      if (keyForm.currentState!.validate()) {
                        Const.LOADIG(context);
                        authProvider.user.email=idController.text;
                        authProvider.user.password=passwordController.text;
                        final result=await authProvider.loginByTypeUser(context,typeUser: typeUser);
                        Get.back();
                        if(result['status'])
                          Get.to(() => HomeView(),
                              transition: Transition.circularReveal);
                        FocusManager.instance.primaryFocus!.unfocus();

                      } else {
                        Get.snackbar("Error", "Please fill all");
                      }
                    },
                  ),
                ),
                if(typeUser.contains(AppConstants.collectionUser))
                FadeInRightBig(
                  child: TextButton(
                    onPressed: () {
                      Get.off(() => SignupView(),
                          transition: Transition.leftToRightWithFade);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr(
                            LocaleKeys.new_member,
                          ),
                          style: getRegularStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          tr(
                            LocaleKeys.signup,
                          ),
                          style: getRegularStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 10.sp)
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                )
                // ,FadeInDownBig(
                //   child: ButtonApp(
                //     text: tr(LocaleKeys.done),
                //     textColor: ColorManager.white,
                //     onPressed: () async {
                //
                //         Const.LOADIG(context);
                //
                //         final result=await CreateEnvironmentProvider().createAdmins(context);
                //         Get.back();
                //         if(result['status'])
                //         FocusManager.instance.primaryFocus!.unfocus();
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
