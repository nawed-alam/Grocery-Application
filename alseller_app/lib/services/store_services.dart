import '../const/firebase_const.dart';

class StoreServices{

  //get users data.

  static getProfile(uid){
   print(uid);
    return firestore.collection(vendorCollection).where('id',isEqualTo: uid).snapshots();

  }
  static getproducts(uid){
    return firestore.collection(productCollection).where('p_vender_id',isEqualTo: uid).snapshots();
  }

//   // get cart
//   static  getCart(uid){
//     return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
//   }
//   //delete document 
// static deleteDocument(docId){
// return firestore.collection(cartCollection).doc(docId).delete();
// }
 static getOrders(uid){
  return firestore.collection(ordersCollection).where('vendors',arrayContains: currentUser!.uid).snapshots();
 }
// static getPopularProducts(uid){
//   return firestore.collection(productCollection).where('p_vender_id',isEqualTo: uid).orderBy('p_wishlist'.length);
// }
//  static getWishlist(){
//   return firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
//  }

//  static getCounts ()async{
//   var res = await Future.wait([
//     firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
//       return value.docs.length;
//     }),
//    firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
//       return value.docs.length;
//     }),
//     firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
//       return value.docs.length;
//     })
//   ]);
//   return res;
//  }

//  static allproducts(){
//   return firestore.collection(productCollection).snapshots();
//  }

//  static getFeatured(){
//   return firestore.collection(productCollection).where('is_featured',isEqualTo: true).get();
//  }
//  static getTrend(){
//   return firestore.collection(productCollection).where('is_trend',isEqualTo: true).get();
//  }

//  static searchProducts(title){
//   return firestore.collection(productCollection).get();
//  }

//  static getSubCategoryProducts(title){
//   return firestore.collection(productCollection).where('p_subcategory',isEqualTo: title).snapshots();
//  }

 }