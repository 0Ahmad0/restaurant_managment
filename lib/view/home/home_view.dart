import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/meal_provider.dart';
import 'package:restaurant_managment/model/utils/sizer.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';

import 'widgets/home_view_body.dart';
import 'widgets/main_screen.dart';
import 'widgets/menu_screen.dart';

class HomeView extends StatelessWidget {
   HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: HomeViewBody(),
    );
  }
}




