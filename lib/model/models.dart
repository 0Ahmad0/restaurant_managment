import 'dart:convert';


import 'package:flutter/cupertino.dart';

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
    //var data=json.data();
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

//Meal
class Meal {
  String id;
  int count=0;
  String mealNameAr;
  String mealNameEn;
  String photoUrl;
  String photoUrlLocal;
  String mealDetailsAr;
  String mealDetailsEn;
  String price;
  String category;

  Meal(
      { this.id="",
        required this.mealNameAr,
        required this.mealNameEn,
        required this.photoUrl,
         this.photoUrlLocal="",
         this.count=0,
        required this.mealDetailsAr,
        required this.mealDetailsEn,
        required this.price,
        required this.category,});
  factory Meal.fromJson( json){
    //var data=json.data();
    return Meal(
        id: json['id'],
        mealNameAr: json["mealNameAr"],
        mealNameEn: json["mealNameEn"],
        photoUrlLocal: json["photoUrlLocal"],
        photoUrl: json["photoUrl"],
        mealDetailsAr: json["mealDetailsAr"],
        mealDetailsEn: json["mealDetailsEn"],
        price: json["price"],
        //count: (json["count"]!=null)?json["count"]:0,
     //   count: json["count"],
        category: json["category"]);
        //category: (json["category"]!=null)?json["category"]:"");
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'mealDetailsAr':mealDetailsAr,
    'mealNameEn':mealNameEn,
    'mealNameAr':mealNameAr,
    'photoUrl':photoUrl,
    'photoUrlLocal':photoUrlLocal,
    'mealDetailsAr':mealDetailsAr,
    'price':price,
    'count':count,
    'category':category,
    'mealDetailsEn':mealDetailsEn,
  };
}
//Meals
class Meals {
  List<Meal> meals;
  //DateTime date;

  Meals({
    required this.meals
  });
  factory Meals.fromJson( json){
    List<Meal> tempList = [];
    for(int i=0;i<json.length;i++){
      Meal temp=Meal.fromJson(json[i]);
      temp.id=json[i].id;
      tempList.add(temp);
    }
    return Meals(
        meals: tempList
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempList = [];
    for(Meal meal in meals){
      tempList.add(meal.toJson());
    }
    return {
      'meals':tempList,
    };
  }
}

//Order
class Order {
  String id;
  Meal? meal;
  String orderNotes;
  DateTime orderTime;
  String orderId;
  int count=0;

  Order(
      { this.id="",
        required this.meal,
        required this.orderId,
        this.orderNotes="",
        this.count=0,
        required this.orderTime,});
  factory Order.fromJson( json){
    //var data=json.data();
    return Order(
        id: json['id'],
        meal: Meal.fromJson(json["meal"]),
        orderId: json["orderId"],
        orderNotes: json["orderNotes"],
        count: json["count"],
        orderTime: json["orderTime"].toDate(),
       );
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'meal':meal?.toJson(),
    'orderId':orderId,
    'orderNotes':orderNotes,
    'count':count,
    'orderTime':orderTime,
  };
}

//Orders
class Orders {
  String id;
  String idUser;
  Map<String,Order> orders;
  DateTime orderTime;
  String orderNotes;
  String orderId;
  String totalPrice;
  String status;
  Orders({
    required this.orders,
    required this.id,
    required this.idUser,
    required this.orderTime,
     this.orderNotes="",
     this.status="current",
     this.orderId="",
     this.totalPrice="0",
  });
  factory Orders.fromJson( json){
    Map<String,Order> tempMap = {};
    for(String orderKey in json["orders"].keys){
      Order temp=Order.fromJson(json["orders"][orderKey]);
      tempMap[orderKey]=temp;
    }
    return Orders(
        id: json["id"],
        orders: tempMap,
      idUser: json["idUser"],
      orderId: json["orderId"],
      orderTime: json["orderTime"].toDate(),
      orderNotes: json["orderNotes"],
      status: json["status"],
      totalPrice: json["totalPrice"],
    );
  }
  Map<String,dynamic> toJson(){
    Map tempMap = {};
    for(String orderKey in orders.keys){
      tempMap[orderKey]=orders[orderKey]?.toJson();
    }
    return {
      'orders':tempMap,
      'id':id,
      'idUser':idUser,
      'orderId':orderId,
      'orderTime':orderTime,
      'status':status,
      'orderNotes':orderNotes,
      'totalPrice':totalPrice,
    };
  }
}

//Meals
class ListOrders {
  List<Orders> listOrders;
  //DateTime date;

  ListOrders({
    required this.listOrders
  });
  factory ListOrders.fromJson( json){
    List<Orders> tempList = [];
    for(int i=0;i<json.length;i++){
      Orders temp=Orders.fromJson(json[i]);
      temp.id=json[i].id;
      tempList.add(temp);
    }
    return ListOrders(
        listOrders: tempList
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempList = [];
    for(Orders orders in listOrders){
      tempList.add(orders.toJson());
    }
    return {
      'listOrders':tempList,
    };
  }
}
enum StateOrder{
  expired,
  current,
  rejected
}


/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
