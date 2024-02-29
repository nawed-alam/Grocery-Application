import 'package:alseller_app/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  var navIndex = 0.obs;
  var username = '';
getUserName()async{
var n =await firestore.collection(vendorCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
  if(value.docs.isNotEmpty){
    return value.docs.single['vendor_name'];
  }
}
);
username =n;
}
}