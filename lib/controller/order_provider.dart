import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';
import 'package:restaurant_managment/controller/utils/firebase.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';

import '../model/utils/const.dart';
import 'package:restaurant_managment/model/models.dart' as model;

class OrderProvider extends ChangeNotifier{
  model.Order order=model.Order(meal: null, orderId: "", orderTime: DateTime.now());
  Orders orders=Orders(orders: {}, id: "", idUser: "", orderTime:  DateTime.now());

  addOrder(context,{ required model.Orders orders}) async {
    orders.orderTime=DateTime.now();
    orders.orderId=Timestamp.now().seconds.toString();
    final result =await FirebaseFun.addOrder(orders: orders);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  
  // updateMeal({ required Meal meal}){
  //
  //   this.user=user;
  //   m = TextEditingController(text: user.name);
  //   email = TextEditingController(text: user.email);
  //   phoneNumber = TextEditingController(text: user.phoneNumber);
  //   notifyListeners();
  // }
  // editMeal(context) async {
  //   Meal tempUser= Meal.fromJson(meal.toJson());
  //
  //   /// print(tempUser.toJson());
  //   var result =await FirebaseFun.updateUserEmail(user: tempUser);
  //   if(result['status']){
  //     result =await FirebaseFun.updateUser(user: tempUser);
  //     if(result['status']){
  //       updateUser(user:models.User.fromJson(result['body']));
  //       notifyListeners();
  //     }
  //   }
  //   print(result);
  //   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
  //   return result;
  // }
  //
  // Future uploadImage(context,XFile image) async {
  //   //Const.LOADIG(context);
  //   var url=await FirebaseFun.uploadImage(image: image,folder: "profileImage");
  //   print('url $url');
  //   if(url==null)
  //     Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
  //   else{
  //     user.photoUrl=url;
  //   }
  //   //Navigator.of(context).pop();
  // }

}