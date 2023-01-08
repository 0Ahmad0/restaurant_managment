import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/meal_provider.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';

import 'widgets/add_meal_view_body.dart';

class AddMealView extends StatelessWidget {
  const AddMealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MealProvider mealProvider= Provider.of<MealProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_meal)),
      ),
      body: AddMealViewBody(mealProvider:mealProvider),
    );
  }
}
