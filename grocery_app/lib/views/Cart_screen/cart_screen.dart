import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/controler/cart_controller.dart';
import 'package:grocery_app/services/firestore_services.dart';
import 'package:grocery_app/views/Cart_screen/shipping_screen.dart';
import 'package:grocery_app/widget_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Shopping Cart'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: 'Cart is empty'.text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot=data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.network("${data[index]['img']}", width: 80, fit: BoxFit.cover),
                            title: "${data[index]['title']}".text.fontFamily(semibold).make(),
                            subtitle: "${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                // Remove item from the cart
                                FirestoreServices.deleteDocument(data[index].id);
                              },
                              color: redColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Total price'.text.fontFamily(semibold).color(darkFontGrey).make(),
                        Obx(()=> "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
                      ],
                    ).box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGrey)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ourButton(
                        color: redColor,
                        onPress: () {
                          // Proceed to shipping
                          Get.to(()=>const ShippindDetails());
                        },
                        textColor: whiteColor,
                        title: 'Proceed to shipping',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
