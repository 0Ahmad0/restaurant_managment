

import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:restaurant_managment/controller/utils/firebase.dart';


import '../model/models.dart' as models;
import '../model/utils/const.dart';
import '../model/utils/local/storage.dart';

class ProfileProvider with ChangeNotifier{
  final serial_number = TextEditingController(text: "000-252-1456-6222");
   var name = TextEditingController(text: "أحمد الحريري");
  var email = TextEditingController(text: "Ahmad2001@gmail.com");
  bool nameIgnor = true;
  bool emailIgnor = true;
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
  updateUser({ required models.User user}){

    this.user=user;
     name = TextEditingController(text: user.name);
     email = TextEditingController(text: user.email);
     notifyListeners();
  }
   editUser(context) async {
     models.User tempUser= models.User.fromJson(user.toJson());
     tempUser.email =email.text;
     tempUser.name=name.text;
    /// print(tempUser.toJson());
     var result =await FirebaseFun.updateUserEmail(user: tempUser);
     if(result['status']){
        result =await FirebaseFun.updateUser(user: tempUser);
       if(result['status']){
         updateUser(user:models.User.fromJson(result['body']));
         notifyListeners();
       }
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
   logout(context)async{
     var result =await FirebaseFun.logout();
     if(result['status']){
       user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
       AppStorage.depose();
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }

   Future uploadImage(context,XFile image) async {
     //Const.LOADIG(context);
     var url=await FirebaseFun.uploadImage(image: image,folder: "profileImage");
     print('url $url');
     if(url==null)
       Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
     else{
       user.photoUrl=url;
     }
     //Navigator.of(context).pop();
   }



/**
  Future<void> phoneSignIn({required String phoneNumber}) async {
    await FirebaseFun.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await FirebaseFun.auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
  **/
}