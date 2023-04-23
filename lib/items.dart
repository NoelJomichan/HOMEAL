import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Items extends StatelessWidget {

  Items({required this.name, required this.desc, required this.price});

  late String name;
  late String desc;
  late num price;

  Items.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
  : name = snapshot['name'],
    desc = snapshot['Description'],
    price = snapshot['price'];


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
