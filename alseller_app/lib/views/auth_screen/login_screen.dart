import 'package:alseller_app/controller/auth_controller.dart';
import 'package:alseller_app/views/home_screen/home.dart';
import 'package:alseller_app/widgets/our_button.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../const/const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.heightBox,
            normalText(text: welcome,size:18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(icLogo,
            width: 70,
            height:70,
            ).box.border(color: white).rounded.padding(const EdgeInsets.all(8)).make(),
            10.widthBox,
            boldText(text: appname,size: 20.0)
              ],
            ),
            40.heightBox,
            normalText(text:loginTo,size: 18.0,color: lightGrey),
            10.heightBox,
            Obx(() =>  Column(children: [
                TextFormField(
                  controller: controller.emailcontroller,
                  decoration:const InputDecoration(
                    filled:true,
                    fillColor: textfieldGrey,
                    hintText: emailHint,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email,color: purpleColor,)
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: controller.passwordcontroller,
                  decoration:const InputDecoration(
                    filled:true,
                    fillColor: textfieldGrey,
                    hintText: passwordHint,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock,color: purpleColor,)
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){},child: normalText(text: forgotPassword,color: purpleColor),),
                ),
                20.heightBox,
                SizedBox(
                  width: context.screenWidth-90,
                  child:controller.isloading.value?const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(red),
                   ) : ourButton(
                    title: login,
                    onPress: ()async{
                      // Get.to(()=>Home());
                      controller.isloading(true);
                        await controller.loginMetthod(context: context).then((value){
                          if(value!=null){
                            VxToast.show(context, msg: "Logged in");
                          Get.offAll(()=> const Home());
                          controller.isloading(false);
                          }else{
                            controller.isloading(false);
                          }
                        });
                    },
                  ),
                )
              ],).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
            ),
            10.heightBox,
            Center(child: normalText(text: anyProblem,color: lightGrey),),
            const Spacer(),
            Center(child: boldText(text: credit),),
            20.heightBox,
          ],
          ),
          
        ),
      ),
    );
  }
}