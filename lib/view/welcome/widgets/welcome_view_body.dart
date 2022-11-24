import 'package:flutter/material.dart';
import 'package:restaurant_managment/model/utils/sizer.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';

import 'build_logo_container.dart';
import 'build_option_auth.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
           buildContainerLogo(context),

          const Spacer(),
          buildOptionAuthApp(context)
        ],
      ),
    );
  }


}
