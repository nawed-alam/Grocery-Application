import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/controler/cart_controller.dart';
import 'package:grocery_app/views/home_screen/home.dart';
import 'package:grocery_app/widget_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      ()=>
       Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child:controller.placingOrder.value 
          ? const Center(
             child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          )
           :ourButton(
            onPress: ()async{
             await controller.placeMyOrder(orderpaymentMethod:paymentMethods[controller.paymentIndex.value],totalAmount: controller.totalP.value );
             await controller.clearCart();
            VxToast.show(context, msg: "Order placded Successfully");
             Get.offAll(const Home());
            },
            title: "Place my Order",
            color: redColor,
            textColor: whiteColor,
          ),
        ),
        body: Padding(padding: const EdgeInsets.all(16),
        child: Obx (()=> Column(
            children:List.generate(paymentMethodsImg.length, (index){
              return GestureDetector(
                onTap: (){
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12) ,border: Border.all(
                    color: controller.paymentIndex.value ==index ?redColor:Colors.transparent,
                    width: 5,
                    
                  )),
                  
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                    Image.asset(paymentMethodsImg[index],
                    colorBlendMode:controller.paymentIndex.value == index ? BlendMode.darken :BlendMode.color,
                    color:controller.paymentIndex.value == index ? Colors.black.withOpacity(0.3 ):Colors.transparent,
                    width: double.infinity,height: 120,fit: BoxFit.fill,),
                  controller.paymentIndex.value ==index?  Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        value: true, onChanged: (value){}),
                    ):Container(),
                    Positioned(
                      bottom: 8,
                      right: 10,
                      child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make()),
                  ], 
                    ),
                ),
              );
            }),
          ),
        ),),
      ),
    );
  }
}