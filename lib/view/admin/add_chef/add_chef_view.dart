import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';

import '../../../controller/auth_provider.dart';
import 'widgets/add_chef_view_body.dart';

class AddChefView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_chef)),
      ),
      body: AddChefViewBody(authProvider: authProvider),
    );
  }
}
