import 'package:flutter/cupertino.dart';
import 'package:restaurant_managment/model/models.dart';

class FunctionHelperViewProvider with ChangeNotifier {
  static chooseNameByLanguage({required String? ar, required String? en}){
    if(Advance.language)
      return ar;
    else return en;
  }
}