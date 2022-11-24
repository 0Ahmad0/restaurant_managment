import 'package:flutter/material.dart';

import 'widgets/meals_view_body.dart';

class MealsView extends StatelessWidget {
  const MealsView({Key? key, required this.title, required this.image}) : super(key: key);
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: MealsViewBody(image: image,)
    );
  }
}
