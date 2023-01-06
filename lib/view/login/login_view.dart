import 'package:flutter/material.dart';
import '../../controller/auth_provider.dart';
import 'widgets/login_view_body.dart';
import 'package:provider/provider.dart';
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginViewBody(authProvider: authProvider,),
    );
  }
}
