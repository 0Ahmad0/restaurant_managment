import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/model/utils/const.dart';
import 'package:restaurant_managment/view/home/widgets/menu_container.dart';
import 'package:restaurant_managment/view/meals/meals_view.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../translations/locale_keys.g.dart';
import '../../manager/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: Text(
          tr(LocaleKeys.menu),
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: .75),
          itemCount: ConstApp.images.length,
          itemBuilder: (_, index) => MenuContainer(
                map: ConstApp.images,
                index: index,
                onTap: ()=>Get.to(()=>MealsView(
                  title: ConstApp.images[index.toString()][1],
                  image: ConstApp.images[index.toString()][0],
                )),
              )),
    );
  }
}
