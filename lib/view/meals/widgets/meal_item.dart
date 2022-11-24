import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../translations/locale_keys.g.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key, required this.name, required this.price
    , required this.ingredients,
  }) : super(key: key);
  final String name;
  final String price;
  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSize.s12,
      shadowColor: ColorManager.primaryColor.withOpacity(.5),
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m24,
          vertical: AppMargin.m8
      ),
      child: ListTile(
          contentPadding: EdgeInsets.all(AppPadding.p40),
          title: Text(name,style: getBoldStyle(color: ColorManager.primaryColor,fontSize: 12.sp),),
          subtitle: Wrap(
            children: [
              for(var i = 0 ; i < ingredients.length;i++)
                Text(ingredients[i] + ' , ',style: getLightStyle(color: ColorManager.secondaryColor,fontSize: 8.sp),),
            ],
          ),
          trailing: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: price,style: getRegularStyle(color: ColorManager.black,fontSize: 8.sp)),
                    TextSpan(text: ' '+tr(LocaleKeys.sr),
                        style: getLightStyle(color: ColorManager.error,
                            fontSize: 8.sp)),
                  ]
              )
          )
        // trailing: Text(ConstApp.meals[index].price + "SR",style: getRegularStyle(color: ColorManager.black,),),
      ),
    );
  }
}
