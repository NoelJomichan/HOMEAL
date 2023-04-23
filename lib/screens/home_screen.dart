import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeal_flutter/constants.dart';
import 'package:homeal_flutter/home_page.dart';
import 'package:homeal_flutter/screens/login_page.dart';
import 'package:homeal_flutter/screens/retailer_page.dart';
import 'package:homeal_flutter/widgets/current_location_screen.dart';
import '../Extraction/get_retailer_name.dart';
import '../widgets/CategoriesWidget.dart';
import '../widgets/NearYouWidget.dart';
import '../widgets/PopulaWidget.dart';
import 'package:homeal_flutter/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  // CollectionReference _referenceRetailerlist = FirebaseFirestore
  //     .instance.collection('Retailer');
  // late Stream <QuerySnapshot> _streamRetailerLocation;
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  // List<String> docIDs = [];       //doc IDs
  // late List<Map> docIDs;
  List<String> docIDs = [];

  Future getDocID() async {
    docIDs.clear();

    await FirebaseFirestore.instance.collection('Retailer').get().then(
              (snapShot) => snapShot.docs.forEach((element) {
            // print(element.reference);
            docIDs.add(element.reference.id);
            // print(docIDs);
          }));
    print(docIDs);
    await location.getCurrentLocation();
    return docIDs;
    // location.latitude = 129812.2;
    // location.longitude = 40811.3;
  }

  Location location = Location();

  void getLocation() async{
    // location.getCurrentLocation();
    // print(location.latitude);
    // print(location.longitude);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Retailer')
        .doc(_auth.currentUser?.uid)
        .collection('RetailerLocation')
        .get();

    final allCoords = querySnapshot.docs.map((e) =>
    "[${e.get('coords').latitude}, ${e.get('coords').longitude}]");

    print(allCoords);
  }

  @override
  void initState() {
    // docIDs.clear();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: -200,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: kBackDropElipseColorOne,
                      borderRadius: BorderRadius.all(Radius.circular(kBackDropRadius),),
                    ),
                  ),),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: kBackDropElipseColorTwo,
                      borderRadius: BorderRadius.all(Radius.circular(kBackDropRadius),),
                    ),
                  ),),
                Positioned(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 150.0,
                      sigmaY: 150.0,
                    ),
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                    ),
                  ),),
                SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/diamond.png')),
                            )
                          ),
                          const Text(
                            'Good Morning \nNoel',
                            style: TextStyle(
                              // fontFamily: 'Pacifico',
                              fontSize: 11
                            ),
                          ),
                          GestureDetector(
                            child: Icon(Icons.logout),
                            onTap: ()async{
                              Navigator.pop(context);
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              blurRadius: 10.0,
                              offset: Offset(5, 7),
                              color: Colors.grey.shade700,
                            )]
                          ),
                          child: const TextField(
                            cursorColor: kSearchTextColor,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              hintText: 'What would you like to eat?',
                              hintStyle: TextStyle(
                                color: kHintTextColor,
                                // fontFamily: 'Pacifico',
                                fontSize: 12.0,
                              ),
                            ),
                            style: TextStyle(
                              color: kSearchTextColor,
                            ),
                          ),
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 10),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // fontFamily: 'Pacifico',
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                      CategoriesWidget(),

                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 10),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Popular",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // fontFamily: 'Pacifico',
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                      PopularWidget(),

                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 10),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Near you",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // fontFamily: 'Pacifico',
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                                                      // NearYouWidget(),
                      SizedBox(
                        height: size.height/2,
                        child: FutureBuilder(
                          future: getDocID(),
                          builder: (context, snapshot){
                            if(snapshot.hasData) {
                          return ListView.builder(
                            itemCount: 20 ,
                            itemBuilder: (context, index) {
                              print(index);
                              print(docIDs[index]);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: (){
                                    // Navigator.pushNamed(context, HomePage.id);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(docId: docIDs[index])));
                                    // print(index);
                                    // print(docIDs[index+6]);
                                  },
                                  title: GetRetailerName(documentID: docIDs[index], userGeoPoint: location,),
                                  textColor: Colors.grey[500],
                                  tileColor: Colors.blue[100],

                                ),
                              );
                            },
                          );

                          }
                            else{
                            return Container();
                        }}
                        ),
                      ),
                    //  drawer widget: 42.32
                    ],
                  ),

                ),
              ],
            ),
          ),
        ),



      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
        ],),
        child: FloatingActionButton(onPressed: (){
          getLocation();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> const CurrentLocationScreen()));
        },
          child: Icon(
            CupertinoIcons.location_fill,
            size: 25,
          ),
        ),
      ),
    );
  }
}
