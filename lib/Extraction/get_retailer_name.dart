import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeal_flutter/location.dart';

class GetRetailerName extends StatelessWidget {

  late Location userGeoPoint;
  final String documentID;

  GetRetailerName({required this.documentID, required this.userGeoPoint});

  @override
  Widget build(BuildContext context) {
    
    CollectionReference users = FirebaseFirestore.instance.collection('Retailer');
    GeoPoint geoVar;
    var dist;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            geoVar = data['location'];
            dist = Geolocator.distanceBetween(userGeoPoint.latitude, userGeoPoint.longitude, geoVar.latitude, geoVar.longitude);
            return Text('Name: ${data['Name']} \nDistance: ${getNumber(dist*100)} km');
          }
          return Text('Loading...');
        }
        );
  }
  getNumber(double input, {int precision = 2}) =>

    double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

}
