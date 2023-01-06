import 'package:flutter/material.dart';
import 'package:restaurant_managment/view/home/home_view.dart';

import '../../model/models.dart';
import '../../model/utils/local/storage.dart';
import '../login/login_view.dart';
import '../welcome/welcome_view.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      ///Navigator.pushReplacementNamed(context, '/login_screen');
    });
  }

  init(context,authProvider,profileProvider) async {
    await AppStorage.init();
    print("f ${Advance.uid}");
    if(Advance.isLogined&&Advance.token!=""){
      final result = await authProvider.fetchUser(uid: Advance.uid);
      if(result['status']){
        profileProvider.updateUser(user:User.fromJson(result['body']));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => HomeView()));
      }else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => LoginView()));
      }

    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeView()
            //HomeView()
            // LoginView()
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
