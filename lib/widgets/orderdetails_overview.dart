import '../look/customerorder_look.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetailsoverview extends StatelessWidget {
  final String id;
  OrderDetailsoverview({this.id});
  Widget details(BuildContext context, String left, String right) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.fromLTRB(5, 20, 7, 7),
        child: Row(children: [
          Container(
            width: size.width * 0.38,
            child: Text(left,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          Text(right,
              textAlign: TextAlign.start,
              //maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("orders").doc(id).snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final order = snap.data;
        return new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        details(
                          context,
                          "Name                :",
                          order["address"]["name"],
                        ),
                        details(context, "Address             :",
                            "${order["address"]["address"]}"),
                        details(context, "Phone_number  :",
                            "${order["address"]["phone_no"]}"),
                        //
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 20, 10, 10),
                          child: Text("Order-List:",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ),
                        Container(
                          height: size.height * 0.5,
                          child: ListView.builder(
                            itemCount: order["order_list"].length,
                            itemBuilder: (ctx, index) {
                              //   List<Map<String,String>> items=[{'name':}];
                              return CustomerOrderinglook(
                                  title: order["order_list"][index]["title"],
                                  imageurl: order["order_list"][index]
                                      ["imageurl"],
                                  id: order["order_list"][index]["id"],
                                  price: order["order_list"][index]["price"],
                                  quantity: order["order_list"][index]
                                      ["quantity"],
                                  index: (index + 1).toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
