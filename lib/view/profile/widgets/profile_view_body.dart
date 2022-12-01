import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';
import 'package:restaurant_managment/view/manager/widgets/textformfiled_app.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/values_manager.dart';

class ProfileViewBody extends StatefulWidget {
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
    // final loginProvider = Provider.of<LoginProvider>(context);
    // profileProvider.serial_number.text=profileProvider.user.serialNumber;
    return Container(
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
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: AppSize.s4)),
                      child: image == null
                          ? ClipOval(
                              child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              width: 4.w,
                              height: 4.h,
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
                            ))
                          : ClipOval(
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
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
