import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_managment/controller/utils/firebase.dart';
import 'package:restaurant_managment/model/models.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';

import '../model/utils/const.dart';

class MealProvider extends ChangeNotifier{
  Meal meal= Meal(mealNameAr: '', mealNameEn: '', photoUrl: '', mealDetailsAr: '', mealDetailsEn: '', price: '', category: '');
  Meals listMeals=Meals(meals: []);
  Map mapMeals={
    "0":[],
    "1":[],
    "2":[],
    "3":[],
  };
  Meals listMealsAppetizer=Meals(meals: []);
  Meals listMealsDrink=Meals(meals: []);
  Meals listMealsMainDishes=Meals(meals: []);
  Meals listMealSalad=Meals(meals: []);
  addMeal(context,{ required Meal meal,required XFile? image}) async {
    var result;

    String url=AppConstants.photoMeal;
    if(image!=null){
       url=await FirebaseFun.uploadImage(image: image!, folder: AppConstants.collectionMeal);
    }
    meal.photoUrl=url;
    if(url==null)
      result = await FirebaseFun.errorUser("the image is empty or failed");
    else
      result =await FirebaseFun.addMeal(meal: meal);
    print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  fetchMeals () async {
    var result= await FirebaseFun.fetchMeals();
    if(result['status']){
      listMeals=Meals.fromJson(result['body']);
    }
    return result;
  }
  fetchMealsCategoryAppetizer() async {
    var result= await FirebaseFun.fetchMealsCategory(categories: ["Appetizer","المقبلات"]);
    if(result['status']){
      listMealsAppetizer=Meals.fromJson(result['body']);
    }
    return result;
  }
  fetchMealsCategorySalad() async {
    var result= await FirebaseFun.fetchMealsCategory(categories: ["Salad","السلطات"]);
    if(result['status']){
      listMealSalad=Meals.fromJson(result['body']);
    }
    return result;
  }
  fetchMealsCategoryMainDishes() async {
    var result= await FirebaseFun.fetchMealsCategory(categories: ["Main Dishes","الأطباق الرئيسية"]);
    if(result['status']){
      listMealsMainDishes=Meals.fromJson(result['body']);
    }
    return result;
  }
  fetchMealsCategoryDrink() async {
    var result= await FirebaseFun.fetchMealsCategory(categories: ["Drinks","المشروبات"]);
    if(result['status']){
      listMealsDrink=Meals.fromJson(result['body']);
    }
    return result;
  }
  processMeals(){
    listMealsAppetizer.meals.clear();
    listMealSalad.meals.clear();
    listMealsMainDishes.meals.clear();
    listMealsDrink.meals.clear();
    for(Meal meal in listMeals.meals){
      if(meal.category.contains("Appetizer")||meal.category.contains("المقبلات")){
        listMealsAppetizer.meals.add(meal);
      }else if(meal.category.contains("Salad")||meal.category.contains("السلطات")){
        listMealSalad.meals.add(meal);
      }
      else if(meal.category.contains("Main Dishes")||meal.category.contains("الأطباق الرئيسية")){
        listMealsMainDishes.meals.add(meal);
      }
      else if(meal.category.contains("Drinks")||meal.category.contains("المشروبات")){
        listMealsDrink.meals.add(meal);
      }
    }
    print("Meals Appetizer :${listMealsAppetizer.meals.length}");
    print("Meal Salad :${listMealSalad.meals.length}");
    print("Meals MainDishes :${listMealsMainDishes.meals.length}");
    print("Meals Drink :${listMealsDrink.meals.length}");
    mapMeals["0"]=listMealsDrink.meals;
    mapMeals["1"]=listMealsMainDishes.meals;
    mapMeals["2"]=listMealsAppetizer.meals;
    mapMeals["3"]=listMealSalad.meals;
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