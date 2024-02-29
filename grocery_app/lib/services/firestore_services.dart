import 'package:flutter/foundation.dart';
import 'package:grocery_app/consts/firebase_const.dart';

class FirestoreServices{

  //get users data.

  static getUser(uid){
   
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();

  }
  static getproducts(Category){
    return firestore.collection(productCollection).where('p_category',isEqualTo: Category).snapshots();
  }

  // get cart
  static  getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }
  //delete document 
static deleteDocument(docId){
return firestore.collection(cartCollection).doc(docId).delete();
}
 static getAllOrders(){
  return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
 }

 static getWishlist(){
  return firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
 }

 static getCounts ()async{
  var res = await Future.wait([
    firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
      return value.docs.length;
    }),
   firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
      return value.docs.length;
    }),
    firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
      return value.docs.length;
    })
  ]);
  return res;
 }

 static allproducts(){
  return firestore.collection(productCollection).snapshots();
 }

 static getFeatured(){
  return firestore.collection(productCollection).where('is_featured',isEqualTo: true).get();
 }
 static getTrend(){
  return firestore.collection(productCollection).where('is_trend',isEqualTo: true).get();
 }

 static searchProducts(title){
  return firestore.collection(productCollection).get();
 }

 static getSubCategoryProducts(title){
  return firestore.collection(productCollection).where('p_subcategory',isEqualTo: title).snapshots();
 }

}