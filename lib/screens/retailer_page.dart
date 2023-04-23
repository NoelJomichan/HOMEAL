import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeal_flutter/screens/shopping_cart.dart';

import '../items.dart';


class RetailerPage extends StatefulWidget {

  RetailerPage({super.key});

  var uid;

  @override
  State<RetailerPage> createState() => _RetailerPageState();

  static const id = 'retailer_page';


}

class _RetailerPageState extends State<RetailerPage> {

  // CollectionReference itemList = FirebaseFirestore.instance.collection('item_macro');
  // itemList.doc(FirebaseAuth.instance.currentUser?.uid);

  final CollectionReference _posts = FirebaseFirestore.instance.collection('item_macro');

  getPost(){
    final innerCollectionReference = _posts.doc(firebaseUser.uid).collection('items');
    return innerCollectionReference.snapshots();
  }

  var firebaseUser = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
      ),
      body:
      StreamBuilder(
        stream: getPost(),
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    if (streamSnapshot.hasData) {
    return ListView.builder(
    itemCount: streamSnapshot.data!.docs.length, //number of rows
    itemBuilder: (context, index) {
    final DocumentSnapshot documentSnapshot =
    streamSnapshot.data!.docs[index];
    return Card(
    margin: const EdgeInsets.all(10),
    child: ExpansionTile(
    title: Text(documentSnapshot["name"]),
    // subtitle: Text(
    // "Plates: ${documentSnapshot["Food Amount"].toString()}"),
    expandedAlignment: Alignment.centerLeft,
    childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
    backgroundColor: Colors.grey[300],
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Item: ${documentSnapshot["items"]}",
    textAlign: TextAlign.end,
    style: const TextStyle(
    fontSize: 15,
    letterSpacing: 0.5,
    color: Colors.black,
    )),
    Text("Customisation: ${documentSnapshot["macro"]}",
    textAlign: TextAlign.start,
    style: const TextStyle(
    fontSize: 15,
    letterSpacing: 0.5,
    color: Colors.black,
    )),
    // Text("Pickup Time: ${documentSnapshot["pTime"]}",
    // textAlign: TextAlign.start,
    // style: const TextStyle(
    // fontSize: 16,
    // letterSpacing: 0.5,
    // color: Colors.black,
    // )),
    // Text("Pickup Date: ${documentSnapshot["pDate"]}",
    // textAlign: TextAlign.start,
    // style: const TextStyle(
    // fontSize: 16,
    // letterSpacing: 0.5,
    // color: Colors.black,
    // )),
    // Text("Address: ${documentSnapshot["pAddress"]}",
    // textAlign: TextAlign.start,
    // style: const TextStyle(
    // fontSize: 15,
    // letterSpacing: 0.5,
    // color: Colors.black,
    // )),
    ],
    )
    ],
    ));
    },
    );
    }

    return const Center(
    child: CircularProgressIndicator(),
    );
    },
    ),
      // SafeArea(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(height: 48.0,),
      //       Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 24.0),
      //         child: Text("Good Morning",),
      //       ),
      //       SizedBox(height: 24.0,),
      //       Padding(
      //         padding: const EdgeInsets.all(24.0),
      //         child: Divider(),
      //       ),
      //       FutureBuilder<DocumentSnapshot>(
      //           future: itemList.doc(FirebaseAuth.instance.currentUser?.uid).collection('items').doc().get(),
      //           builder:
      //               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //
      //             if (snapshot.hasError) {
      //               return Text("Something went wrong");
      //             }
      //
      //             if (snapshot.hasData && !snapshot.data!.exists) {
      //               return Text("Document does not exist");
      //             }
      //
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      //               return Text("Full Name: ${data['name']} ${data['last_name']}");
      //             }
      //
      //             return Text("loading");
      //           },
      //       )
      //
      //     ],
      //   ),
      // ),
    );
  }
}

