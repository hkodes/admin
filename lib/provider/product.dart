import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final int price;
  final String title;
  final int size;
  final String subtitle;
  final String description;
  final String company;
  final String image1;
  final String image2;
  final String image3;
  Product({
  @required this.description,
  @required this.id,
  @required this.price,
  @required this.size,
  @required this.subtitle,
  @required this.title,
  @required this.company,
  @required this.image1,
  @required this.image2,
  @required this.image3,}
  );
}

class Products with ChangeNotifier{
   setSearchParam(String caseNumber) {
  List<String> caseSearchList = List();
  String temp = "";
  for (int i = 0; i < caseNumber.length; i++) {
    temp = temp + caseNumber[i].toUpperCase();
    caseSearchList.add(temp);
  }
  return caseSearchList;
}
  

  Future<void> add(Product product) async{

    
  await FirebaseFirestore.instance.collection("products").doc().set({
    'title':product.title.toUpperCase(),
    'price':product.price,
    'size':product.size,
    'isfavourite':false,
    'imageurl':[product.image1,product.image2,product.image3],
    'subtitle':product.subtitle,
    'description':product.description,
    "caseSearch": setSearchParam(product.title),
    "createdat":Timestamp.now(),
    'stock':1,
   });
   
  }

}