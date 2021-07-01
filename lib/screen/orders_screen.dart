import 'package:flutter/material.dart';

import '../widgets/orderdetails_overview.dart';

class OrderDetailscreen extends StatefulWidget {
  static const route = "OrderDetailscreen";

  _OrderDetailscreen createState() => _OrderDetailscreen();
}

class _OrderDetailscreen extends State<OrderDetailscreen> {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          backgroundColor: Colors.red,
          title: Text("Order Details"),
        ),
        body: OrderDetailsoverview(id: id));
  }
}
