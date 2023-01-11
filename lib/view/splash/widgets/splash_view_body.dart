import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:restaurant_managment/view/welcome/welcome_view.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),
    //        ()=>Get.off(()=>WelcomeView())
    );
    return Center(
      child: FadeInRightBig(
        child: Image.asset(AssetsManager.splashLogoIMG),
      ),
    );
  }
}
