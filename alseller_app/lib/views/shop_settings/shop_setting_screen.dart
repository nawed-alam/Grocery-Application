import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/profile_controller.dart';
import 'package:alseller_app/widgets/costum_textform_feild.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(() => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            title: boldText(text: editProfile,size: 16.0),
            actions: [ 
               controller.isloading.value ?const  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(white),
                            ) : TextButton(onPressed: ()async{
                              controller.isloading(true);
              await controller.updateShop(
                shopname: controller.
              shopnamecontroller.text,shopadd: controller.shopadresscontroller.text,
              shopmob: controller.shopmobilecontroller.text,shopweb: controller.shopwebsitecontroller.text,shopdesc: controller.shopdesccontroller.text);
              VxToast.show(context, msg: "Shop Updated");
            },child: normalText(text: save),)],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                customTextField(label: shopname,hint: nameHint,controller:controller.shopnamecontroller),
                10.heightBox,
                customTextField(label: address,hint: shopAdressHint,controller: controller.shopadresscontroller),
                10.heightBox,
                customTextField(label: mobile,hint: shopMobileHint,controller: controller.shopmobilecontroller),
                10.heightBox,
                customTextField(label: website,hint: shopWebsiteHint,controller: controller.shopwebsitecontroller),
                10.heightBox,
                customTextField(isDesc: true,label: description,hint: shopDescHint,controller: controller.shopdesccontroller),
        
                
              ],
            ),
          ),
        ),
    );
  }
}