import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:homeal_flutter/screens/home_screen.dart';
import 'package:homeal_flutter/screens/retailer_page.dart';
import 'package:homeal_flutter/screens/retailer_register_page.dart';
import 'package:homeal_flutter/screens/signup_page.dart';
import '../constants.dart';
import '../text_field_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  final _formKey = GlobalKey<FormState>();

  bool isSwitched = false;
  var textValue = 'Customer';

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Retailer';
      });
      // print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Customer';
      });
      // print('Switch Button is OFF');
    }
  }


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
                          const SizedBox(height: 80.0,),
                          Hero(
                            tag: 'homeal_text',
                            child: homealLogoText(fontSize: kHomealSize, color: kHomealColor,),),
                          const SizedBox(height: 100.0,),
                          // labelTextInput(
                          //   label: 'E-Mail',
                          //   color: kHomealColor,
                          //   isPassword: false,
                          //   textColor: kTextFieldColor,
                          // ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
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
                          const SizedBox(height: 50.0,),
                          // labelTextInput(
                          //   label: 'Password',
                          //   color: kHomealColor,
                          //   isPassword: true,
                          //   textColor: kTextFieldColor,
                          // ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
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
                          const SizedBox(height: 30.0,),
                          Switch(
                              value: isSwitched,
                              onChanged: toggleSwitch
                          ),
                          Text('$textValue', style: TextStyle(
                            fontSize: 15,
                            color: kHomealColor,
                          ),),


                          const SizedBox(height: 60.0,),
                          // loginButton(
                          //   bgColor: kLoginBgColor,
                          //   btnText: 'LOGIN',
                          //   textColor: kHomealColor,
                          //   context: context,
                          //   routeName: HomeScreen.id
                          // ),
                          GestureDetector(
                            onTap: () async{

                              if(_formKey.currentState!.validate()){

                                setState(() {
                                  showSpinner = true;
                                });

                              try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  if (user != null) {
                                    if (isSwitched) {
                                      Navigator.pushNamed(
                                          context, RetailerPage.id);
                                    }else{
                                      Navigator.pushNamed(
                                          context, HomeScreen.id);
                                    }
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                } catch (e){
                                setState(() {
                                  showSpinner = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(e.toString()))
                                  );
                                });
                                print(e);
                              }}},
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
                                  'LOGIN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kHomealColor,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 90.0,),
                          signUpLabel(label: 'Don’t have an account yet?', color: kTextFieldColor),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, SignupPage.id);
                            },
                            child: signUpLabel(label: 'Sign Up', color: kHomealColor),
                          ),
                          SizedBox(height: 5,),
                          signUpLabel(label: 'OR Sign Up as a Retailer?', color: kTextFieldColor),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: signUpLabel(label: 'Retailer Sign Up', color: kHomealColor),
                          ),
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
