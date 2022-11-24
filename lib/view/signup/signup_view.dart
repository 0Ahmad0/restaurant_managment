import 'package:flutter/material.dart';

import 'widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupViewBody(),
    );
  }
}
