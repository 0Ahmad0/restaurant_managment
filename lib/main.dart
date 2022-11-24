import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_managment/firebase_options.dart';
import 'package:restaurant_managment/view/resourse/theme_manager.dart';
import 'package:restaurant_managment/view/splash/splash_view.dart';
import 'package:sizer/sizer.dart';
import 'translations/codegen_loader.g.dart';
Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("en"),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
          title: "Restaurant Management",
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          // locale: Get.deviceLocale,
          locale: Locale('ar'),
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.myTheme,
          // theme: getApplicationTheme(isDark: appProvider.darkTheme),
          home:SplashView()
        );
      }
    );
  }
}

//          FocusManager.instance.primaryFocus!.unfocus();
