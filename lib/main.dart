import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_managment/model/models.dart';
import '/controller/meal_provider.dart';
import '/controller/order_provider.dart';
import '/controller/utils/firebase.dart';
import '/firebase_options.dart';
import '/view/resourse/theme_manager.dart';
import '/view/splash/splash_view.dart';
import 'package:sizer/sizer.dart';
import 'controller/account_provider.dart';
import 'controller/auth_provider.dart';
import 'controller/home_provider.dart';
import 'controller/profile_provider.dart';
import 'controller/theme_provider.dart';
import 'translations/codegen_loader.g.dart';
import 'package:provider/provider.dart';
Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();

   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
   GetStorage.init();

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
    return MultiProvider(providers: [
    Provider<HomeProvider>(create: (_)=>HomeProvider()),
    //ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
      ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
      ListenableProvider<ProfileProvider>(create: (_)=>ProfileProvider()),
      ListenableProvider<MealProvider>(create: (_)=>MealProvider()),
      ListenableProvider<OrderProvider>(create: (_)=>OrderProvider()),
      ListenableProvider<ThemeProvider>(create: (_)=>ThemeProvider()),
      ListenableProvider<AccountProvider>(create: (_)=>AccountProvider()),
    ],
    child:
      Sizer(
        builder: (context, orientation, deviceType) {
          return ChangeNotifierProvider<ThemeProvider>.value(
            value: Provider.of<ThemeProvider>(context),
          child: Consumer<ThemeProvider>(
            builder: (_,value,child){
              return GetMaterialApp(
                  title: "Restaurant Management",
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  debugShowCheckedModeBanner: false,
                  theme:!value.isDark? ThemeManager.myTheme:ThemeManager.myThemeDark,
                  // theme: getApplicationTheme(isDark: appProvider.darkTheme),
                  home:SplashView()
              );
            },
          ),
          );
      }
    ));
  }
}

//          FocusManager.instance.primaryFocus!.unfocus();
