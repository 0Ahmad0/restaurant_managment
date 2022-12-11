import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/textformfiled_app.dart';
import 'package:restaurant_managment/view/resourse/assets_manager.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class AddMealViewBody extends StatefulWidget {
  const AddMealViewBody({Key? key}) : super(key: key);

  @override
  State<AddMealViewBody> createState() => _AddMealViewBodyState();
}

class _AddMealViewBodyState extends State<AddMealViewBody> {
  ImagePicker picker = ImagePicker();

  XFile? image;

  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // await uploadImage( );
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                    "https://images.techhive.com/images/article/2017/05/pcw-translate-primary-100723319-large.jpg",
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
                  iconData: Icons.restaurant,
                  hintText: tr(LocaleKeys.meal_name_ar)
              ),
            ),
            const SizedBox(width: AppSize.s40,),
            Expanded(
              child: TextFiledApp(
                  iconData: Icons.restaurant,
                  hintText: tr(LocaleKeys.meal_name_en)
              ),
            ),
          ],
        ),
        TextFiledApp(
            iconData: Icons.set_meal,
            hintText: tr(LocaleKeys.meal_details_ar)
        ),
        TextFiledApp(
            iconData: Icons.set_meal,
            hintText: tr(LocaleKeys.meal_details_en)
        ),
        TextFiledApp(
            iconData: Icons.price_change,
            hintText: tr(LocaleKeys.meal_price),
          keyboardType: TextInputType.number,
        ),
      ],
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
                    Expanded(
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
                  ],
                ),
              ),
            ),
          );
        });
  }

}
