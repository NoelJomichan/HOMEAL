import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:homeal_flutter/constants.dart';
import 'package:homeal_flutter/screens/home_screen.dart';
import 'package:homeal_flutter/screens/login_page.dart';
import 'package:homeal_flutter/screens/retailer_register_page.dart';
import 'package:homeal_flutter/text_field_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:homeal_flutter/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const String id = 'signup_page';


  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String name;
  late String email;
  late String c_number;
  late String address;
  late String pinCode;
  late String password;
  // late Location location;

  final _firestore = FirebaseFirestore.instance;

  void getLocation() async{
    Location location = Location();
    await location.getCurrentLocation();
    // _firestore.collection('Consumer').add({
    //   'Name' : name,
    //   'location' : GeoPoint(location.latitude, location.longitude)
    // });
    _firestore.collection('Consumer').doc(_auth.currentUser?.uid)
        .collection('ConsumerLocation')
        .add({'coords': GeoPoint(location.latitude, location.longitude), 'name' : name});
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
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
                    Positioned(child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 150,
                        sigmaY: 150,
                      ),
                      child: SizedBox(
                        height: size.height,
                        width: size.width,
                      ),
                    ),),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 60.0,),
                            Hero(
                              tag : 'homeal_text',
                              child: homealLogoText(fontSize: kHomealSmallSize, color: kHomealColor,),),
                            const SizedBox(height: 60.0,),
                            TextFormField(
                              style: TextStyle(
                                color: kHomealColor,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Enter your Name',
                                labelStyle: TextStyle(color: kHomealColor,),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                                  return 'Enter Proper Name';
                                }else{
                                  return null;
                                }
                              },
                              onChanged: (value){
                                name = value;
                              },
                            ),
                            const SizedBox(height: 30.0,),
                            TextFormField(
                              style: TextStyle(
                                color: kHomealColor,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Enter your E-Mail',
                                labelStyle: TextStyle(color: kHomealColor,),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,5}$').hasMatch(value!)){
                                  return 'Enter Proper E-Mail';
                                }else{
                                  return null;
                                }
                              },
                              onChanged: (value){
                                email = value;
                              },
                            ),
                            const SizedBox(height: 30.0,),
                            TextFormField(
                              style: TextStyle(
                                color: kHomealColor,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Enter your Mobile Number',
                                labelStyle: TextStyle(color: kHomealColor,),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\./0-9]+$').hasMatch(value!)){
                                  return 'Enter Proper Number';
                                }else{
                                  return null;
                                }
                              },
                              onChanged: (value){
                                c_number = value;
                              },
                            ),
                            const SizedBox(height: 30.0,),
                            TextFormField(
                              obscureText: true,
                              style: TextStyle(
                                color: kHomealColor
                              ),
                              decoration: InputDecoration(
                                labelText: 'Enter Password',
                                labelStyle: TextStyle(color: kHomealColor,),
                              ),
                              validator: (value){
                                // if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!)){
                                if(value!.isEmpty || !RegExp(r'^.{6,}$').hasMatch(value!)){
                                  return 'Enter Proper Number';
                                }else{
                                  return null;
                                }
                              },
                              onChanged: (value){
                                password = value;
                              },
                            ),
                            // TextField(
                            //   obscureText: true,
                            //   decoration: InputDecoration(
                            //     labelText: 'Password',
                            //     labelStyle: TextStyle(color: kHomealColor,),
                            //   ),
                            //   onChanged: (value){
                            //     password = value;
                            //   },
                            // ),
                            const SizedBox(height: 30.0,),
                            const SizedBox(height: 30.0,),
                            const SizedBox(height: 50.0,),
                            GestureDetector(

                              onTap: ()async {

                                if(_formKey.currentState!.validate()){

                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                      email: email, password: password);
                                  getLocation();

                                  if (newUser != null){
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }else{
                                    Navigator.pushNamed(context, LoginPage.id);
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                                catch(e){
                                  setState(() {
                                    showSpinner = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(e.toString()))
                                    );
                                  });
                                  print(e);
                                }
                                }
                              },
                              child: Container(
                                width: 180.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                    color: kLoginBgColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color: Colors.grey,
                                          offset: Offset(-5, 7)
                                      ),]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                    color: kHomealColor,
                                    fontSize: 15.0,
                                  ),
                              ),
                                ),
                              ),
                            ),
                              // loginButton(
                              //   bgColor: kLoginBgColor,
                              //   btnText: 'Sign Up',
                              //   textColor: kHomealColor,
                              //   context: context,
                              //   routeName: RegisterPage.id,
                              //   onTap: tapFunction,
                              // ),
                            // ),
                            const SizedBox(height: 150.0,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )

      ),
    );
  }
}
