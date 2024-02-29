

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';

import '../consts/firebase_const.dart';

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
  //signupMethod
  Future<UserCredential?> signupMetthod ({email,password,context})async {
  UserCredential? userCredential ;
  try{
   userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch(e){
 VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}

//storing data method 

storeUserMethod ({name,password,email})async{
  DocumentReference store = firestore.collection(userCollection).doc(currentUser!.uid);
  store.set({
    'name':name,
    'password':password,
    'email':email,
    'imageUrl':"",
    'id':currentUser!.uid,
    'cart_count':"00",
    'order_count':"00",
    'wishlist_count':"00"
  });

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