import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/controler/home_controler.dart';

class CartController extends GetxController{
  var totalP =0.obs;

  //text controller for shipping details
var addresscontroller= TextEditingController();
var citycontroller= TextEditingController();
var statecontroller= TextEditingController();
var postalcontroller= TextEditingController();
var phonecontroller= TextEditingController();

var placingOrder =false.obs;
var paymentIndex = 0.obs;
late dynamic productSnapshot; 
var products=[];
var vendors=[];
  calculate(data){
    totalP.value =0;
    for(var i=0;i<data.length;i++){
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }
  changePaymentIndex(index){
  paymentIndex.value = index;
  }
  placeMyOrder({
   required orderpaymentMethod,required totalAmount})async{
    placingOrder(true);

    await getProductDetails();
   await  firestore.collection(ordersCollection).doc().set({
    'order_code':"233981237",
    'order_date':FieldValue.serverTimestamp(),
    'order_by':currentUser!.uid,
    'order_by_name':Get.find<HomeControler>().username,
    'order_by_email':currentUser!.email,
    'order_by_address':addresscontroller.text,
    'order_by_city':citycontroller.text,
    'order_by_state':statecontroller.text,
    'order_by_postalCode':postalcontroller.text,
    'order_by_phone':phonecontroller.text,
    'shipping_method':"Home Delivery",
    'payment_method':orderpaymentMethod,
    'order_placed':true,
    'total_amount':totalAmount,
    'orders':FieldValue.arrayUnion(products),
    'order_confirmed':false,
    'order_delivered':false,
    'order_on_delivery':false,
    'vendors':FieldValue.arrayUnion(vendors),
   });
placingOrder(false);
  }
  getProductDetails(){
    products.clear();
    vendors.clear();
    for(int i=0;i<productSnapshot.length;i++){
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'tprice':productSnapshot[i]['tprice'],

      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  
  }
   clearCart(){
    for(var i =0;i<productSnapshot.length ;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
   } 
}