import 'package:flutter/material.dart';

class CustomerOrderinglook extends StatelessWidget {
  final String imageurl;
  final String id;
  final int price;
  final String title;
  final String index;
  final int quantity;

  CustomerOrderinglook(
      {this.id,
      this.imageurl,
      this.price,
      this.quantity,
      this.title,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(19),
          child: Stack(
            children: <Widget>[
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Flexible(child: Text(index)),
                    Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(imageurl)))),
                    Flexible(child: Text(title)),
                    Flexible(
                        child: Text(
                            '${quantity.toString()} x ₹${price.toString()}')),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
