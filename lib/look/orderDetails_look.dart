import 'package:flutter/material.dart';

import '../screen/orders_screen.dart';


class OrderDetailsLook extends StatefulWidget {
  final String name;
  final String address;
  final String district;
  final String id;
  final String items;

  OrderDetailsLook(
      {Key key, this.name, this.address, this.district, this.id, this.items})
      : super(key: key);

  @override
  _OrderDetailsLookState createState() => _OrderDetailsLookState();
}

class _OrderDetailsLookState extends State<OrderDetailsLook> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.all(10.0),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(OrderDetailscreen.route, arguments: widget.id);
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.redAccent,
                elevation: 25,
                child: Container(
                  padding: new EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: new EdgeInsets.all(5),
                          child: Row(children: [
                            Text("Name: ",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white70)),
                            Text(widget.name,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                          ])),
                      Container(
                          padding: new EdgeInsets.all(5),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address: ",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white70)),
                                Text(
                                    "${widget.address.trim()}\n${widget.district}",
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ])),
                      Container(
                          padding: new EdgeInsets.all(5),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("No.of orders: ",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white70)),
                                Text("${widget.items}",
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ])),
                    ],
                  ),
                ))));
  }
}
