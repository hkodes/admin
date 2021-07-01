import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchenappliances/screen/appdrawer.dart';

import '../look/orderDetails_look.dart';

class OrdersList extends StatelessWidget {
  static const route = "./orderlist";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("orders"),backgroundColor: Colors.red,),
          body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final orderDetails = snap.data.documents;
         if (orderDetails.length <= 0) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/NoData.png",
                  ),
                  height: size.height * 0.25,
                ),
                Center(
                  child: Text(
                    "No Products Availabel",
                    style: TextStyle(color: Colors.green, fontSize: 23),
                  ),
                )
              ],
            )),
          );
        }
          return ListView.builder(
            itemCount: orderDetails.length,
            itemBuilder: (ctx, index) {
              return OrderDetailsLook(
                  id: orderDetails[index].documentID,
                  name: orderDetails[index]["address"]["name"],
                  address: orderDetails[index]["address"]["address"],
                  district: orderDetails[index]["address"]["district"],
                  items: (orderDetails[index]["order_list"].length).toString());
            },
          );
        },
      ),
      drawer: Appdrawer(),
    );
  }
}
