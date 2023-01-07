import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';

import '../../controller/profile_provider.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
   ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isIgnor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState((){
              isIgnor = !isIgnor;
              print(isIgnor);
            });
          }, icon: Icon(Icons.edit))
        ],
        title: Text(tr(LocaleKeys.profile)),
      ),
      body:ChangeNotifierProvider<ProfileProvider>.value(
          value: Provider.of<ProfileProvider>(context),
    child: Consumer<ProfileProvider>(
    builder: (context, value, child) =>
      ProfileViewBody(isIgnor: isIgnor,profileProvider: value,))),
    );
  }
}
