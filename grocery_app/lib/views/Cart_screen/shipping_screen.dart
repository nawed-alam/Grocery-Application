import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/controler/cart_controller.dart';
import 'package:grocery_app/views/Cart_screen/payment_method.dart';
import 'package:grocery_app/widget_common/custom_textfield.dart';
import 'package:grocery_app/widget_common/our_button.dart';

class ShippindDetails extends StatelessWidget {
  const ShippindDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:AppBar(
        title: "Shipping Info ".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addresscontroller.text.length>10){
              Get.to(() => const PaymentMethods());
            }else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          title: "Continue",
          color: redColor,
          textColor: whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            customTextField(hint: "Address",isPass: false,title: "Adress",controller: controller.addresscontroller),
            customTextField(hint: "City",isPass: false,title: "City",controller: controller.citycontroller),
            customTextField(hint: "State",isPass: false,title: "State",controller: controller.statecontroller),
            customTextField(hint: "Postal Code",isPass: false,title: "Postal Code",controller: controller.postalcontroller),
            customTextField(hint: "Phone Number",isPass: false,title: "Phone Number",controller: controller.phonecontroller),
          ],
        ),
      ),
    );
  }
}