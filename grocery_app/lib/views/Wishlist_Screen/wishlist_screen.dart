

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(stream:FirestoreServices.getWishlist(), builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
      if(!snapshot.hasData){
         return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(redColor),
          ),
          );
      }
      else if(snapshot.data!.docs.isEmpty){
        return  "No Wishlist yet!".text.color(darkFontGrey).makeCentered();
      }
     else{
      var data = snapshot.data!.docs;
       return  Column(
         children: [
           Expanded(
             child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Image.network("${data[index]['p_images'][0]}", width: 80, fit: BoxFit.cover),
                                  title: "${data[index]['p_name']}".text.fontFamily(semibold).make(),
                                  subtitle: "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: ()async {
                                      // Remove item from the cart
                                    await firestore.collection(productCollection).doc(data[index].id).set({
                                      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                                    },SetOptions(merge: true));

                                    },
                                    color: redColor,
                                  ),
                                ),
                              );
                            },
                          ),
           ),
         ],
       );
     }
      } ,
      ),
    );
  }
}