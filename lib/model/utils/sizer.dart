import 'package:flutter/cupertino.dart';

class SizerApp{
  static double getH(context){
    return MediaQuery.of(context).size.height;
  }
  static double getW(context){
    return MediaQuery.of(context).size.width;
  }
}