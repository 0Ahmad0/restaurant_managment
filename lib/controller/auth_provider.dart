
import 'package:flutter/cupertino.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';
import 'package:restaurant_managment/controller/utils/firebase.dart';

import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../model/utils/consts_manager.dart';
import '../model/utils/local/storage.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier{
  var keyForm = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
  signup(context) async{
    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    bool checkPhoneOrEmailFound =await FirebaseFun.checkPhoneOrEmailFound(email:user.email, phone: user.phoneNumber);
    var result;
    if(checkPhoneOrEmailFound){
     result =await FirebaseFun.signup(email: user.email, password: user.password);
    if(result['status']){
      user.uid=result['body']['uid'];
      result = await FirebaseFun.createUser(user: user);
      if(result['status']){

        await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
        await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
        await AppStorage.storageWrite(key: AppConstants.uidKEY, value: user.uid);
        await AppStorage.storageWrite(key: AppConstants.tokenKEY, value: "resultUser['token']");
        Advance.isLogined = true;
        user= models.User.fromJson(result['body']);
        profileProvider.updateUser(user:User.fromJson(result['body']));
      }
    }}
    else{
      result=FirebaseFun.errorUser("the email or phoneNumber already uses");
    }
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  signupAD(context) async{
    name.text ="Admin hiba";
    email.text ="admin4@gmail.com";
    phoneNumber.text ="0999888774";
    password.text ="123456";
    String description="";
    String photoUrl=AppConstants.photoProfileAdmin;
    String typeUser=AppConstants.collectionAdmin;
    var result =await FirebaseFun.signup(email: email.text, password: password.text);
    if(result['status']){
      user= models.User(id: "",uid:result['body']['uid'],
          name: name.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          password: password.text
          ,photoUrl: photoUrl,
          typeUser: typeUser,
          description: description);
      result = await FirebaseFun.createUser(user: user);
      if(result['status']){
        user= models.User.fromJson(result['body']);
        // print(result);

      }else{
        // print(result);
      }
    }else{
      //print(result);
    }
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
    /*if(result['status']){
    }else{
    }*/
    // user.uid=result['body']['uid'];
  }
  login(context) async{
    var result=await loginWithPhoneNumber(context);
    if(!result['status'])
      result=await loginWithEmil(context);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  loginWithEmil(context) async{
    var resultUser =await FirebaseFun.login(email: user.email, password: user.password);
    var result;
    if(resultUser['status']){
      resultUser = await fetchUser(uid: resultUser['body']['uid']);
      result=await _baseLogin(context, resultUserAfterLog: resultUser);
    }else{
      result=resultUser;
    }
    return result;
  }
  loginWithPhoneNumber(context) async{
    var resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password);
    var result;
    result=await _baseLogin(context, resultUserAfterLog: resultUser);
    return result;
  }
  _baseLogin(context,{required var resultUserAfterLog}) async{

    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    var result=resultUserAfterLog;
    if(result['status'])
    {
      await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
      Advance.isLogined = true;
      user= models.User.fromJson(result['body']);
      await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.id);
      await AppStorage.storageWrite(key: AppConstants.uidKEY, value: user.uid);
      await AppStorage.storageWrite(key: AppConstants.tokenKEY, value: "resultUser['token']");
      Advance.token = user.uid;
      Advance.uid = user.uid;
      email.clear();
      password.clear();
      profileProvider.updateUser(user:User.fromJson(result['body']));
    }
    return result;
  }


  loginUid(String uid) async{
    var result = await fetchUser(uid: uid);
    if(result['status']){
      await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
      Advance.isLogined = true;
      user= models.User.fromJson(result['body']);
      await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
      Advance.token = user.uid;
      email.clear();
      password.clear();
      // print(result);
    }
    print(result);
    //Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
    /*if(result['status']){
    }else{
    }*/
    // user.uid=result['body']['uid'];
  }
  fetchUser({required String uid}) async {
    var result= await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionUser);
    // print(result);
    if(result['status']&&result['body']==null){
      result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionCompany);
      if(result['status']&&result['body']==null){

        result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionAdmin);
        if(result['status']&&result['body']==null){
          result={
            'status':false,
            'message': "account invalid"//LocaleKeys.toast_account_invalid,
          };
        }
      }
    }
    return result;
  }
  sendPasswordResetEmail(context,{required String resetEmail}) async{
    var result =await FirebaseFun.sendPasswordResetEmail(email: resetEmail);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
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

