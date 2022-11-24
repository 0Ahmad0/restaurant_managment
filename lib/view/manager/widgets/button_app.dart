import 'package:flutter/material.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:sizer/sizer.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({Key? key,
     this.color = ColorManager.primaryColor,
    required this.text,
     this.radius = 12.0,
    required this.onPressed, this.textColor = ColorManager.black,
  }) : super(key: key);
  final Color? color;
  final Color? textColor;
  final String text;
  final double? radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!)
        )
      ),
      onPressed: onPressed,
      child: Text(text,style: TextStyle(
        color: textColor,
        fontSize: SizerUtil.width / 28,
        fontFamily: 'Marhey'
      ),),
    );
  }
}
