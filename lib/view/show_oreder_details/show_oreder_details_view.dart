import 'package:flutter/material.dart';
import 'package:restaurant_managment/model/models.dart';

import 'widgets/show_oreder_details_view_body.dart';

class ShowOrderDetailsView extends StatelessWidget {
  const ShowOrderDetailsView({Key? key, required this.orders, required this.index}) : super(key: key);
  final Orders orders;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ToDo : type here Order Number
      appBar: AppBar(title: Text('#${orders.orderId}'),),
      body: ShowOrderDetailsViewBody(orders:orders,index:index),
    );
  }
}
