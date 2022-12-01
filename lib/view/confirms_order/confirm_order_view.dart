import 'package:flutter/material.dart';

import 'widgets/confirm_order_view_body.dart';

class ConfirmOrderView extends StatelessWidget {
  const ConfirmOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmOrderViewBody(),
    );
  }
}
