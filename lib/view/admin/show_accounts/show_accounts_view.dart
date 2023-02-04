import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/account_provider.dart';
import 'package:restaurant_managment/controller/profile_provider.dart';

import '../../../translations/locale_keys.g.dart';
import 'widgets/show_accounts_view_body.dart';

class ShowAccountsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileProvider  profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (ZoomDrawer.of(context)!.isOpen()) {
                ZoomDrawer.of(context)!.close();
              } else {
                ZoomDrawer.of(context)!.open();
              }
            },
            icon: const Icon(
              Icons.menu,
            ),
          ),
          title: Text(
            tr(LocaleKeys.accounts),
          ),
        ),
        body:
      ChangeNotifierProvider<AccountProvider>.value(
    value: Provider.of<AccountProvider>(context),
    child: Consumer<AccountProvider>(
    builder: (context, value, child) =>
      ShowAccountsViewBody(profileProvider: profileProvider,accountProvider: value,),))
    );
  }
}
