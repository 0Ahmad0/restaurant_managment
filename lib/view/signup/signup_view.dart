import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controller/auth_provider.dart';

import 'widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SignupViewBody(authProvider: authProvider,),
    );
  }
}
