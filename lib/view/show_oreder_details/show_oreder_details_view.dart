import 'package:flutter/material.dart';

import 'widgets/show_oreder_details_view_body.dart';

class ShowOrderDetailsView extends StatelessWidget {
  const ShowOrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ToDo : type here Order Number
      appBar: AppBar(title: Text('order Number #142'),),
      body: ShowOrderDetailsViewBody(),
    );
  }
}
