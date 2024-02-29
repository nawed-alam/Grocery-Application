import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../const/const.dart';
import '../const/firebase_const.dart';

class AuthController extends GetxController{
var isloading = false.obs;
  //text controller 
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  // login method
Future<UserCredential?> loginMetthod ({context})async {
  UserCredential? userCredential ;
  try{
    userCredential = await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
  } on FirebaseAuthException catch(e){
    
 VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}
  //signoutMethod 
  signoutMethod(context)async{
    try{
      await auth.signOut();
    }catch(e){
     VxToast.show(context, msg: e.toString());
  }

  }

}