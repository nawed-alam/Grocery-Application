
import 'package:alseller_app/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class OrdersCotroller extends GetxController{
  var orders =[];
  var confirmed=false.obs;
  var ondelivery=false.obs;
  var delivered=false.obs;
getOrders(data){
  orders.clear();
for(var item in data['orders']){
  if(item['vendor_id']==currentUser!.uid){
    orders.add(item);
  }
}
}

 changeStatus({title,status,docID})async{
var store = firestore.collection(ordersCollection).doc(docID);
await store.set({
  title:status,
},SetOptions(merge: true));

 }
}