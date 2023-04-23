import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  late GoogleMapController googleMapController;
  static const initialCameraPosition = CameraPosition(target: LatLng(19.033341, 73.042466), zoom: 14);
  // Set<Marker> markers ={};

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(specify['location'].latitude , specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Shops', snippet: specify['Name'])
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('Retailer').get().then((value) {
      if(value.docs.isNotEmpty){
        for(int i = 0; i < value.docs.length; i++){
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  void initState(){
    getMarkerData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Set<Marker> getMarker(){
      return <Marker>[
        Marker(
          markerId: MarkerId('Retailer Location'),
          position: LatLng(19.033341, 73.042466),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Retailer')
        )
      ].toSet();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User current Location"),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: FloatingActionButton.extended(
          onPressed: ()async{

            Position position = await _determinePosition();

            googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(
                            position.latitude, position.longitude),
                        zoom: 14)));
            // markers.clear();
            // markers.add(
            //     Marker(
            //         markerId: const MarkerId('currentLocation'),
            //         position: LatLng(position.latitude, position.longitude)
            //     )
            // );
            var markerIdVal = '0.00';
            final MarkerId markerId = MarkerId(markerIdVal);
            final Marker marker = Marker(
                markerId: markerId,
                position: LatLng(position.latitude , position.longitude),
                infoWindow: InfoWindow(title: "You", snippet: 'Noel')
            );
            setState(() {
              markers.removeWhere((key, marker) => marker.markerId.value == "0.00");
              markers[markerId] = marker;
            });

          },
          label: const Text('Your Location'),
          icon: Icon(Icons.location_on_sharp),),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        // markers: markers,
        markers: Set<Marker>.of(markers.values),
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          googleMapController = controller;
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();


    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        return Future.error("Location Permission Denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("Location denied permanently");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;

  }


}
