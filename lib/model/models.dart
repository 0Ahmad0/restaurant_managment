import 'package:flutter/cupertino.dart';
class Meal{
  String name;
  String price;
  List<String> ingredients;

  Meal({required this.name,required this.price,required this.ingredients});
}

class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}
//user
class User {
  String id;
  String uid;
  String name;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;
  User(
      {required this.id,
        required this.uid,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.password,
        required this.typeUser,
        required this.photoUrl,
        this.description="",});
  factory User.fromJson( json){

    return User(id: json['id'],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        typeUser: json["typeUser"],
        photoUrl: json["photoUrl"],
        description: (json["description"]!=null)?json["description"]:"");
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'uid':uid,
    'name':name,
    'email':email,
    'phoneNumber':phoneNumber,
    'password':password,
    'typeUser':typeUser,
    'photoUrl':photoUrl,
    'description':description,
  };
}
//Users
class Users {
  List<User> users;
  //DateTime date;

  Users({
    required this.users
  });
  factory Users.fromJson( json){
    List<User> tempUsers = [];
    for(int i=0;i<json.length;i++){
      User tempUser=User.fromJson(json[i]);
      tempUser.id=json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(
        users: tempUsers
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempUsers = [];
    for(User user in users){
      tempUsers.add(user.toJson());
    }
    return {
      'users':tempUsers,
    };
  }
}

/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
