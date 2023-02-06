import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_managment/controller/account_provider.dart';
import 'package:restaurant_managment/view/resourse/color_manager.dart';
import 'package:restaurant_managment/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/profile_provider.dart';

import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../manager/widgets/ShadowContainer.dart';

class ShowAccountsViewBody extends StatelessWidget {
  ShowAccountsViewBody(
      {required this.accountProvider, required this.profileProvider});

  final AccountProvider accountProvider;
  final ProfileProvider profileProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //prints the messages to the screen0
        future: accountProvider.fetchAllUsers(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Const.SHOWLOADINGINDECATOR();
          }
          {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Const.SHOWLOADINGINDECATOR();
              return ListView.builder(
                itemCount: accountProvider.accounts.users.length,
                itemBuilder: (_, index) => BuildShowAccountItem(
                    index: index, user: accountProvider.accounts.users[index]),
              );

              /// }));
            } else {
              return const Text('Empty data');
            }
          }
        });
  }
}

class BuildShowAccountItem extends StatelessWidget {
  final int index;
  final User user;

  BuildShowAccountItem({super.key, required this.index, required this.user});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          user.name,
          style: getRegularStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontSize: 14.sp),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(user.typeUser),
              style: getRegularStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                  fontSize: 10.sp),
            ),
              RatingBar.builder(
                  initialRating: 0,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                    return SizedBox();
                  },
                  onRatingUpdate: (rating) {}),
          ],
        ),
        trailing: Icon(
          Icons.circle_rounded,
          color: ColorManager.success,
        ),
      ),
    );
  }
}
