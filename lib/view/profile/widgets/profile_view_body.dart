import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/auth_provider.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/textformfiled_app.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../model/utils/const.dart';
import '../../../model/utils/sizer.dart';
import '../../app/picture/cach_picture_widget.dart';
import '../../app/picture/profile_picture_widget.dart';
import '../../manager/widgets/button_app.dart';
import '../../resourse/values_manager.dart';

class ProfileViewBody extends StatefulWidget {
  final bool isIgnor;

  const ProfileViewBody({super.key, required this.isIgnor,required this.profileProvider});
  final ProfileProvider profileProvider;
  @override
  State<ProfileViewBody> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileViewBody> {
  // final name = TextEditingController(text: "أحمد الحريري");

  bool nameIgnor = true;

  bool emailIgnor = true;

  // ProfileProvider profileProvider = ProfileProvider();
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
  removeGallery() async {
    image =null ;
    widget.profileProvider.user.photoUrl=" ";
    ///print(" ${image==null}");
    setState(() {});
  }

//   Future uploadImage() async {
//     try {
//       String path = basename(image!.path);
//       print(image!.path);
//       File file =File(image!.path);
//
// //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
//       Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
//       UploadTask storageUploadTask = storage.putFile(file);
//       TaskSnapshot taskSnapshot = await storageUploadTask;
//       //Const.LOADIG(context);
//       String url = await taskSnapshot.ref.getDownloadURL();
//       //Navigator.of(context).pop();
//       print('url $url');
//       return url;
//     } catch (ex) {
//       //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
//     }
//   }

  @override
  Widget build(BuildContext context) {

    // final profileProvider = Provider.of<ProfileProvider>(context);
     final authProvider = Provider.of<AuthProvider>(context);
    // profileProvider.serial_number.text=profileProvider.user.serialNumber;
    return IgnorePointer(
      ignoring: widget.isIgnor,
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p10, horizontal: AppPadding.p20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: AppSize.s4)),
                        child:  image == null
                            ? ClipOval(
                            child:
                            CacheNetworkImage(
                              photoUrl: '${widget.profileProvider.user.photoUrl}',
                              width: SizerApp.getW(context) * 0.14,
                              height: SizerApp.getW(context) * 0.14,
                              waitWidget: WidgetProfilePicture(
                                name: widget.profileProvider.user.name,
                                radius: AppSize.s30,
                                fontSize: SizerApp.getW(context) / 10,
                              ),
                              errorWidget: WidgetProfilePicture(
                                name: widget.profileProvider.user.name,
                                radius: AppSize.s30,
                                fontSize: SizerApp.getW(context) / 10,
                              ),
                            ))
                            : ClipOval(
                          child: Image.file(File(image!.path),
                            fit: BoxFit.fill,
                          ),
                        ),

                      ),
                      Positioned(
                        bottom: 0,
                        right: context.locale == Locale('en')?null: 0,
                        left: context.locale == Locale('ar')?null: 0,
                        child: Container(
                          width: 10.w,
                          height: 10.w,
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
                        ),
                      )
                    ],
                  ),
                  TextFiledApp(
                    controller: widget.profileProvider.name,
                      iconData: Icons.person,
                      hintText: tr(LocaleKeys.full_name)
                  ),
                  TextFiledApp(
                      controller: widget.profileProvider.email,
                      iconData: Icons.email,
                      hintText: tr(LocaleKeys.email_address)
                  ),
                  TextFiledApp(
                      controller: widget.profileProvider.phoneNumber,
                      iconData: Icons.phone_iphone,
                      hintText: tr(LocaleKeys.mobile_number)
                  ),
                  // TextFiledApp(
                  //     iconData: Icons.lock,
                  //     hintText: tr(LocaleKeys.password)
                  // ),
                  const SizedBox(height: AppSize.s20,),
                  ButtonApp(
                      text: tr(LocaleKeys.edit_password),
                      onPressed: (){
                    final passwordController = TextEditingController();
                    final confirmPasswordController = TextEditingController();
                    final formKey = GlobalKey<FormState>();
                    Get.dialog(
                        Center(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(AppPadding.p20),
                              margin: EdgeInsets.all(AppMargin.m20),
                              height: 34.h,
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(AppSize.s24)
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFiledApp(
                                      controller: passwordController,
                                        iconData: Icons.lock,
                                        hintText: tr(LocaleKeys.new_password),
                                      validator: (value){
                                        if(value!.trim().isEmpty)
                                          return tr(LocaleKeys.field_required);
                                        return null;
                                      },
                                    ),
                                    TextFiledApp(
                                      controller: confirmPasswordController,
                                        iconData: Icons.lock,
                                        hintText: tr(LocaleKeys.confirm_new_password),
                                      validator: (value){
                                        if(value!.trim().isEmpty)
                                          return tr(LocaleKeys.field_required);
                                        if(confirmPasswordController.text.compareTo(passwordController.text)!=0)
                                          return tr(LocaleKeys.enter_matched_password);
                                        return null;
                                      },

                                    ),
                                    Spacer(),
                                    ButtonApp(text: tr(LocaleKeys.done),
                                        onPressed: () async {
                                      if(formKey.currentState!.validate()){
                                        Const.LOADIG(context);
                                        widget.profileProvider.user.password=passwordController.text;
                                        final result =await authProvider.recoveryPassword(context, user: widget.profileProvider.user);
                                        Get.back();
                                        Get.back();
                                      }else{
                                        Get.snackbar("Error", "Please enter same password");
                                      }

                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    );

                  }),
                  const SizedBox(height: AppSize.s20,),
                  ButtonApp(text: tr(LocaleKeys.edit), onPressed: () async {
                    Const.LOADIG(context);
                    if(image!=null)
                      await widget.profileProvider.uploadImage(context, image!);
                    await widget.profileProvider.editUser(context);
                    Navigator.of(context).pop();
                  }),
                ],
              ),
            ),
          )),
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
                              Icon(Icons.delete),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text(tr(LocaleKeys.remove),),
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
