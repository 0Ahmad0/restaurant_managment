import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/ShadowContainer.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/auth_provider.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../home/home_view.dart';

class AddChefViewBody extends StatelessWidget {
  AddChefViewBody({required this.authProvider});
  final formKey = GlobalKey<FormState>();
  final AuthProvider authProvider;
  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
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
                    controller: fullNameController,
                    iconData: Icons.person,
                    hintText: tr(LocaleKeys.full_name),
                  ),
                  TextFiledApp(
                    controller: emailAddressController,
                    iconData: Icons.email,
                    hintText: tr(LocaleKeys.email_address),
                  ),
                  TextFiledApp(
                    controller: passwordController,
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
                    onPressed: () async {
                      if(formKey.currentState!.validate()){
                        Const.LOADIG(context);
                        authProvider.user=User(id: '', uid: '',
                            name: fullNameController.text,
                            email: emailAddressController.text,
                            phoneNumber: ""
                            , password: passwordController.text,
                            typeUser: AppConstants.collectionChef,
                            photoUrl: AppConstants.photoProfileChef);
                        final result=await authProvider.signupAD(context);
                        Get.back();
                        if(result['status'])
                          Get.to(() => HomeView(),
                              transition: Transition.circularReveal);
                      }else{
                        Get.snackbar("Error", "Please fill all");
                      }
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
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
