import 'dart:io';

import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/home_controller.dart';
import 'package:alseller_app/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';


class ProductController extends GetxController{
  var isloading = false.obs;
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList =<String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category =[];
  var pimagesLinks = [];
  var pimagesList =RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories()async{
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat =categoryModelFromJson(data);
    category = cat.categories;
  }

  populatecategoryList(){
    categoryList.clear();
   for(var item in category){
      categoryList.add(item.categoryName);
    }
  }
  populatesubcategoryList(cat){
    subcategoryList.clear();
    var data = category.where((element) =>element.categoryName==cat).toList();
   for(int i=0;i<data.first.subcategories.length;i++){
      subcategoryList.add(data.first.subcategories[i]);
    }
  }
pickImage(index,context)async{
  try{
final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
if(img == null){
return ;
}else{
  pimagesList[index]=File(img.path);
}
  }catch(e){
VxToast.show(context, msg: e.toString());
  }
}

uploadImages()async{
  pimagesLinks.clear();
  for(var item in pimagesList){
       if(item != null){
        var filename = basename(item.path);
    var destination = 'images/vendors/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(item.path));
    var n = await ref.getDownloadURL();
    pimagesLinks.add(n);
       }
  }
}

uploadProducts(context)async{
  var store = firestore.collection(productCollection).doc();
  await store.set({
    'is_featured':false,
    'is_trend':false,
    'p_category':categoryvalue.value,
    'p_subcategory':subcategoryvalue.value,
    'p_colors':FieldValue.arrayUnion([Colors.red.value,Colors.brown.value]),
    'p_images':FieldValue.arrayUnion(pimagesLinks),
    'p_wishlist':FieldValue.arrayUnion([]),
    'p_description':pdescController.text,
    'p_name':pnameController.text,
    'p_price':ppriceController.text,
    'p_quantity':pquantityController.text,
    'p_seller':Get.find<HomeController>().username,
    'p_rating':"5.0",
    'p_vender_id':currentUser!.uid,
    'featured_id':'',
    'trend_id':'',

  });
  isloading(false);
  VxToast.show(context, msg: "Product Uploaded");
}

addFeatured(docId)async{
  await firestore.collection(productCollection).doc(docId).set({
    'featured_id':currentUser!.uid,
    'is_featured':true,
  },SetOptions(merge: true));
}
removeFeatured(docId)async{
  await firestore.collection(productCollection).doc(docId).set({
    'featured_id':'',
    'is_featured':false,
  },SetOptions(merge: true));
}
removeProduct(docId)async{
 await firestore.collection(productCollection).doc(docId).delete();
}


}