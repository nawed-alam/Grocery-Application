import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/firebase_const.dart';

class HomeControler extends GetxController{
@override
  void onInit() {
    getUserName();
    super.onInit();
  }

var currentNavIndex = 0.obs;

var username = '';
var searchController = TextEditingController();
getUserName()async{
var n =await firestore.collection(userCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
  if(value.docs.isNotEmpty){
    return value.docs.single['name'];
  }
}
);
username =n;
}
}