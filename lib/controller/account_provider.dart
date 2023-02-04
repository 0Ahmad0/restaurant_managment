import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_managment/controller/utils/firebase.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';

import '../model/utils/const.dart';
import '../model/utils/consts_manager.dart';

class AccountProvider extends ChangeNotifier{
 Users accounts=Users(users: []);
 Users users=Users(users: []);
 Users chefs=Users(users: []);
 fetchLawyersStream()  {
  accounts.users.clear();
  return FirebaseFirestore.instance.collection(AppConstants.collectionChef).snapshots();
 }
 fetchAllUsers(BuildContext context)  async {
  users.users.clear();
  chefs.users.clear();
  var resultChef=await  FirebaseFun.fetchUsersByTypeUser(typeUser: AppConstants.collectionChef);
  if(resultChef['status'])
   chefs=(Users.fromJson(resultChef['body']));
  var resultUser=await  FirebaseFun.fetchUsersByTypeUser(typeUser: AppConstants.collectionUser);
  if(resultUser['status'])
   users=(Users.fromJson(resultUser['body']));

  accounts.users.clear();
  accounts.users.addAll(chefs.users);
  accounts.users.addAll(users.users);
  (!resultChef['status']&&!resultUser['status'])?
      Const.TOAST(context,textToast: LocaleKeys.toast_network_error):"";
  return resultUser;
 }
}