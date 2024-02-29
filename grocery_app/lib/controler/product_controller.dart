import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];
  var  quantity =0.obs;
  var colorindex =0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  Future<void> getSubCategories(String title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) => element.categoryName == title).toList();
    if (s.isNotEmpty) {
      for (var e in s[0].subcategories) {
        print(e);
        subcat.add(e);
      }
    } else {
      print('No matching categories found for title: $title');
    }
  }

  changecolorIndex(index){
    colorindex.value=index;
  }
  increaseQuantity(totalQuantity){
  if(quantity.value<totalQuantity){
    quantity.value++;
  }
  }
  decreaseQuantity(){
    if(quantity.value>0)
  {
    quantity.value--;
  }
  }

  calculateTotalPrice(price){
   totalPrice.value = price*quantity.value;
  }

  addCart({
    title,img,sellername,color,qty,tprice,context,vendorId
  })async{
    
    await firestore.collection(cartCollection).doc().set({
      'title':title,
      'img' :img,
      'sellername':sellername,
      'color':color,
      'qty':qty,
      'tprice':tprice,
      'added_by':currentUser!.uid,
      'vendor_id':vendorId,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues()async{
    totalPrice.value =0;
    quantity.value=0;
    colorindex.value =0;
    isFav.value =false;
  }
   addToWishlist(docId,context)async{
    await firestore.collection(productCollection).doc(docId).set(
      {'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])},
      SetOptions(merge: true)
    );
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
   }
   removeFromWishlist(docId,context)async{
    await firestore.collection(productCollection).doc(docId).set(
      {'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])},
      SetOptions(merge: true)
    );
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
   }

   checkIffav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
   }
}
