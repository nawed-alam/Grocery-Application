import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/colors.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/controler/product_controller.dart';
import 'package:grocery_app/services/firestore_services.dart';
import 'package:grocery_app/widget_common/our_button.dart';
class ItemsDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemsDetails(  { this.title,super.key,this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading:IconButton(onPressed: (){
              controller.resetValues();
              Get.back();
          },icon: const Icon(Icons.arrow_back),) ,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
          Obx(
            ()=>IconButton(onPressed: (){
              if(controller.isFav.value){
                controller.removeFromWishlist(data.id,context);
              }else{
                controller.addToWishlist(data.id,context);
              }
            }, icon: Icon(Icons.favorite_outlined,color:controller.isFav.value?redColor:darkFontGrey ,)),
          ),
        ]),
        body: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      
                      aspectRatio: 16/9,
                    
                      itemCount: data['p_images'].length,
                       itemBuilder: (context,index){
    
                      return Image.network(
                        data["p_images"][index],width: double.infinity,
                        fit: BoxFit.contain,
                        );
                    },
                ),
                    10.heightBox,
                    //title and details screen
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    //rating 
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value){
    
                    },
                    normalColor: Colors.grey,
                    selectionColor:Colors.amber,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                   // stepInt: true,
                    ),
    
                    10.heightBox,
                    "${String.fromCharCode(8377)} ${double.parse(data['p_price']).numCurrency}".text.color(redColor).fontFamily(bold).size(16).make(),
    
                    10.heightBox,
                    Row(
                      children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                            ],
                          ),
                        ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.message_rounded,color: darkFontGrey,),
                          )
                      ],
                    ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                    //color section
                    20.heightBox,
                    Obx(
                      ()=> Column(
                        children: [
                         
                          //quantity row
                           Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                ()=> Row(
                                 children: [
                                  IconButton(onPressed: (){
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                  }, icon: const Icon(Icons.remove),),
                                  controller.quantity.value.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                                   IconButton(onPressed: (){
                                    controller.increaseQuantity(int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                   }, icon: const Icon(Icons.add),),
                                   10.widthBox,
                                   "(${data['p_quantity']} available ) ".text.color(textfieldGrey).make()
                                 ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //price
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.color(textfieldGrey).make(),
                              ),
                            //  print(controller.totalPrice.value),
                             "${String.fromCharCode(8377)}  ${double.parse(controller.totalPrice.value.toString()).numCurrency}".text.color(redColor).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
    
    
                    //description section 
                    10.heightBox,
                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    "${data['p_description']}".text.color(darkFontGrey).make(),
    
                  10.heightBox,
                  // buttons section
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(itemDetailsButtonsList.length,
                     (index) => ListTile(
                      title: itemDetailsButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                      trailing: const Icon(Icons.arrow_forward),
                     )),
                  ),
                  20.heightBox,
                  productyoumayLike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                  10.heightBox,
                   SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                              future: FirestoreServices.getTrend(),
                              //future: FirestoreServices.getFeatured(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;

                                  return Row(
                                      children: List.generate(
                                    featuredData.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_images'][0],
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make()
                                            .centered(),
                                        10.heightBox,
                                        "${String.fromCharCode(8377)} ${featuredData[index]['p_price']}"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make()
                                            .centered(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .roundedSM
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 5))
                                        .padding(const EdgeInsets.all(8))
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemsDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                    }),
                                  ));
                                }
                              }),
                      ),
                  ],
                ),
              )
            )
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child:ourButton(
                color: redColor,
                onPress: (){
                  if(controller.quantity.value >0){
                    controller.addCart(
                    color: data['p_colors'][controller.colorindex.value],
                    context: context,
                    img: data['p_images'][1],
                    qty: controller.quantity.value,
                    sellername: data['p_seller'],
                    title: data['p_name'],
                    tprice: controller.totalPrice.value,
                   vendorId: data['p_vender_id'],
                  );
                  VxToast.show(context, msg: "Added to cart");
                }else{
                  VxToast.show(context, msg: "Quantity can't be 0");
                }
                  },
                textColor: whiteColor,
                title: "Add to Cart",
              ) ,
            )
          ],
        ),
      ),
    );
  }
}