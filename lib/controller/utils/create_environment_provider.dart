
import 'package:flutter/cupertino.dart';


import '../../model/models.dart' as models;

import '../../model/utils/const.dart';
import '../../model/utils/consts_manager.dart';
import 'firebase.dart';

class CreateEnvironmentProvider with ChangeNotifier{


  List<models.User> listAdmin=[
    models.User(id: "",
        uid: "",
        name: "Admin",
        email: "admin@gmail.com",
        phoneNumber: "0999999991",
        password: "12345678",
        typeUser: AppConstants.collectionAdmin,
        photoUrl: ""),
    models.User(id: "",
        uid: "",
        name: "Admin",
        email: "ad@gmail.com",
        phoneNumber: "0999999992",
        password: "12345678",
        typeUser: AppConstants.collectionAdmin,
        photoUrl: "")
  ];
  createAdmin(context,{int indexListAdmin=0}) async {
    if(listAdmin.length<1){
      return FirebaseFun.errorUser("a user is emty");
    }
    models.User user=listAdmin[indexListAdmin];
    bool checkPhoneOrEmailFound =await FirebaseFun.checkPhoneOrEmailFound(email:user.email, phone: user.phoneNumber);
    var result;
    if(checkPhoneOrEmailFound){
      result =await FirebaseFun.signup(email: user.email, password: user.password);
      if(result['status']){
        user.uid=result['body']['uid'];
        result = await FirebaseFun.createUser(user: user);
        if(result['status']){
          user= models.User.fromJson(result['body']);
        }
      }}
    else{
      result=FirebaseFun.errorUser("the email or phoneNumber already uses");
    }
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  createAdmins(context) async {
    var result;
    if(listAdmin.length<1){
      return FirebaseFun.errorUser("a list admin is empty");
    }
    for(int i=0;i<listAdmin.length;i++){
      result =await createAdmin(context,indexListAdmin: i);
    }
    
    return result;
  }
  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
