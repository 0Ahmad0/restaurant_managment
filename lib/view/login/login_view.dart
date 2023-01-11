import 'package:flutter/material.dart';
import 'package:restaurant_managment/model/utils/consts_manager.dart';
import '../../controller/auth_provider.dart';
import 'widgets/login_view_body.dart';
import 'package:provider/provider.dart';
class LoginView extends StatelessWidget {
  const LoginView({Key? key,this.typeUser="User"}) : super(key: key);
  final String typeUser;
  @override
  Widget build(BuildContext context) {

    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginViewBody(authProvider: authProvider,typeUser:typeUser),
    );
  }
}
