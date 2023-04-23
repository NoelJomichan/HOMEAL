import 'package:flutter/material.dart';
import 'package:homeal_flutter/cart_page.dart';
import 'package:homeal_flutter/home_page.dart';
import 'package:homeal_flutter/screens/itemPage.dart';
import 'package:homeal_flutter/screens/retailer_page.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/retailer_register_page.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() =>  runApp(MyApp());
void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CartModel(),
    child: MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: ItemPage.id,
      routes:{
        LoginPage.id : (context) => LoginPage(),
        SignupPage.id : (context) => SignupPage(),
        RegisterPage.id : (context) => RegisterPage(),
        HomeScreen.id : (context) => HomeScreen(),
        CartPage.id : (context) => CartPage(),
        ItemPage.id : (context) => ItemPage(itemIndex: 0, docId: '01',),
        // HomePage.id : (context) => HomePage(),
        RetailerPage.id : (context) => RetailerPage(),
      },
    ),
    );
  }
}