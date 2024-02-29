import 'package:alseller_app/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const/firebase_const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  var isLoggedin =false;
  CheckUser()async{
    auth.authStateChanges().listen((User? user) { 
      if(user==null && mounted){
        isLoggedin=false;
      }else{
        isLoggedin  = true;
      }
      setState(() {
        
      });
    });
  } 

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Seller',
      theme: ThemeData(
       appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation:0.0)
      ),
      home:const LoginScreen(),
    );
  }
}

