import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../manager/const.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key, required this.map, required this.index, required this.onTap,
  }) : super(key: key);
  final Map map;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pulse(
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: ConstApp.images[index.toString()][0],
          child: Container(
            padding:const EdgeInsets.all(AppPadding.p8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      ColorManager.black.withOpacity(.6), BlendMode.darken),
                  image: AssetImage(ConstApp.images[index.toString()][0]),
                )),
            child: Material(
              color: Colors.transparent,
              child: Text(ConstApp.images[index.toString()][1].toUpperCase(),
                style: getBoldStyle(color: ColorManager.white,
                    fontSize: 16.sp
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
