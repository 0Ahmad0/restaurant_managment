import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/model/utils/const.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';
import 'package:restaurant_managment/view/home/widgets/menu_container.dart';
import 'package:restaurant_managment/view/meals/meals_view.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:restaurant_managment/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/meal_provider.dart';
import '../../../controller/order_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/models.dart';
import '../../../translations/locale_keys.g.dart';
import '../../manager/const.dart';
import '../../manager/widgets/custom_float_actionbutton.dart';
import '../../meals/widgets/cart_shopping_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.mealProvider}) : super(key: key);
  final MealProvider mealProvider;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var getListMeals;
  @override
  void initState() {
    getListMealsFun();
    super.initState();
  }

  getListMealsFun() async {
    getListMeals = FirebaseFirestore.instance
        .collection(AppConstants.collectionMeal)
        .snapshots();
    return getListMeals;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton:
    CustomFloatActionButton(),
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
      body: StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: getListMeals,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                Const.SHOWLOADINGINDECATOR();

            }
            else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                Const.SHOWLOADINGINDECATOR();
                widget.mealProvider.listMeals =Meals.fromJson(snapshot.data?.docs);
                widget.mealProvider.processMeals();
                return buildGrid(context);
                /// }));
              } else {
                return const Text('Empty data');
              }
            }
            else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
  buildGrid(context){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .75),
        itemCount: ConstApp.images.length,
        itemBuilder: (_, index) => MenuContainer(
          map: ConstApp.images,
          index: index,
          onTap: ()=>(widget.mealProvider.mapMeals[index.toString()].length>0)?Get.to(()=>MealsView(
            title: ConstApp.images[index.toString()][1],
            image: ConstApp.images[index.toString()][0],
            meals:widget.mealProvider.mapMeals[index.toString()],
          )): Const.TOAST(context,textToast: tr(LocaleKeys.no_dishes_category)),
        ));
  }
}

