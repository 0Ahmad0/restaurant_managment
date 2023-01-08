import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_managment/controller/meal_provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/model/utils/const.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/button_app.dart';
import 'package:restaurant_managment/view/manager/widgets/textformfiled_app.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/utils/firebase.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../home/home_view.dart';
import '../../../resourse/color_manager.dart';
import '../../../resourse/style_manager.dart';
import '../../../resourse/values_manager.dart';

class AddMealViewBody extends StatefulWidget {
  const AddMealViewBody({Key? key, required this.mealProvider}) : super(key: key);
  final MealProvider mealProvider;
  @override
  State<AddMealViewBody> createState() => _AddMealViewBodyState();
}

class _AddMealViewBodyState extends State<AddMealViewBody> {
  ImagePicker picker = ImagePicker();

  XFile? image;

  final mealNameArController = TextEditingController();
  final mealNameEnController = TextEditingController();
  final categoryController = TextEditingController();
  final photoUrlController = TextEditingController();
  final priceController = TextEditingController();
  final mealDetailsEnController = TextEditingController();
  final mealDetailsArController = TextEditingController();

  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // await uploadImage( );
    setState(() {});
  }
  removeGallery() async {
    image =null ;
    setState(() {});
  }

  late List<String> category;
  final formKey  = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    category =[
      tr(LocaleKeys.drink),
      tr(LocaleKeys.salad),
      tr(LocaleKeys.main_dishes),
      tr(LocaleKeys.appetizer),
    ];
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p40
        ),
        children: [
          SvgPicture.asset(AssetsManager.addMealIMG,
          width: 30.w,
            height: 20.h,
          ),
          SizedBox(height: 2.5.h,),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20),
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: AppSize.s4)),
                child: image == null
                    ? CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                    AppConstants.photoMeal,
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                    )
                    : Image.file(
                      File(image!.path),
                      fit: BoxFit.fill,
                    ),
              ),
              Container(
                margin: const EdgeInsets.all(AppMargin.m12),
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColor),
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  icon: Icon(Icons.edit,size: 15.sp,),
                ),
              )
            ],
          ),
          SizedBox(height: 2.5.h,),
          Row(
            children: [
              Expanded(
                child: TextFiledApp(
                  controller: mealNameArController,
                    iconData: Icons.restaurant,
                    hintText: tr(LocaleKeys.meal_name_ar)
                ),
              ),
              const SizedBox(width: AppSize.s40,),
              Expanded(
                child: TextFiledApp(
                  controller: mealNameEnController,
                    iconData: Icons.restaurant,
                    hintText: tr(LocaleKeys.meal_name_en)
                ),
              ),
            ],
          ),
          TextFiledApp(
            controller: mealDetailsArController,
              iconData: Icons.set_meal,
              hintText: tr(LocaleKeys.meal_details_ar)
          ),
          TextFiledApp(
            controller: mealDetailsEnController,
              iconData: Icons.set_meal,
              hintText: tr(LocaleKeys.meal_details_en)
          ),
          TextFiledApp(
            controller: priceController,
              iconData: Icons.price_change,
              hintText: tr(LocaleKeys.meal_price),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSize.s10,),
          DropdownButtonFormField(
           // value: categoryController.text,
            validator: (val){
              if(val==null)
                return tr(LocaleKeys.field_required);
            },
            decoration: InputDecoration(
              hintText: tr(LocaleKeys.select_category),
                border: OutlineInputBorder()
            ),
            items: [
              for(int i=0;i<category.length;i++)
                DropdownMenuItem(
                  child: Text(category[i]),
                  value: category[i],
                )
            ], onChanged: (String? value) {
            categoryController.text=value!;
            //  print(value);
          },
          ),
          const SizedBox(height: AppSize.s10,),
          ButtonApp(text: tr(LocaleKeys.done), onPressed: () async {
            if(formKey.currentState!.validate()){
              Const.LOADIG(context);
              widget.mealProvider.meal= Meal(mealNameAr: mealNameArController.text, mealNameEn: mealNameEnController.text, photoUrl: "",
                  mealDetailsAr: mealDetailsArController.text, mealDetailsEn: mealDetailsEnController.text,
                  price: priceController.text, category: categoryController.text);
              var result=await widget.mealProvider.addMeal(context, meal: widget.mealProvider.meal, image:image);
              Get.back();
              if(result["status"])
                Get.to(() => HomeView(),
                    transition: Transition.circularReveal);
            }
          })
        ],
      ),
    );
  }
  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Container(
              height: 15.h,
              width: SizerUtil.width - 30.0,
              color: Theme.of(context).cardColor,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.camera,
                                  size: 20.sp),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text(tr(
                                LocaleKeys.camera,
                              ),style: getBoldStyle(
                                  color: ColorManager
                                      .black,
                                  fontSize: 12.sp
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded
                      (
                      child: InkWell(
                        onTap: () {
                          pickFromGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.photo,
                                size: 20.sp,
                              ),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text(
                                tr(LocaleKeys.gallery),
                                style: getBoldStyle(
                                    color: ColorManager
                                        .black,
                                    fontSize: 12.sp
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()  {

                          removeGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.delete,size: 20.sp,),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text(tr(LocaleKeys.remove),
                                style: getBoldStyle(
                                    color: ColorManager
                                        .black,
                                    fontSize: 12.sp
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
