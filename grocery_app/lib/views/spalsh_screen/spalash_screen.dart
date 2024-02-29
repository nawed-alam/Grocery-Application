import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/views/auth_screen/login_screen.dart';
import 'package:grocery_app/widget_common/applogo_widget.dart';

import '../../consts/firebase_const.dart';
import '../home_screen/home.dart';
class SpalashScreen extends StatefulWidget {
  // const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  
  //  creating to method to change screen.
changeScreen(){
  Future.delayed(const Duration (seconds: 1),(){
    auth.authStateChanges().listen((User? user) { 
      if(user== null && mounted){
    Get.to(() => const  LoginScreen());
      }else{
        Get.to(() => const  Home());

      }
    });
  });
}

@override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body:Center(child: Column(
        children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300,)),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              5.heightBox,
              appversion.text.white.make(),
              Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox
        ],
      )) ,
    );
  }
}