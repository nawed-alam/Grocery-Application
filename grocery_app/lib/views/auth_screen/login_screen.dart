import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/controler/auth_controller.dart';
import 'package:grocery_app/views/auth_screen/signup.dart';
import 'package:grocery_app/views/home_screen/home.dart';
import 'package:grocery_app/widget_common/applogo_widget.dart';
import 'package:grocery_app/widget_common/bg_widget.dart';
import 'package:grocery_app/widget_common/custom_textfield.dart';
import 'package:grocery_app/widget_common/our_button.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(AuthController());
    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
           Obx(
              ()=>Column(
                children: [
                  customTextField(hint:emailHint,title: email,isPass: false,controller: controller.emailcontroller),
                  customTextField(hint:passwordHint,title: password,isPass: true,controller: controller.passwordcontroller),
                  Align(alignment: Alignment.centerRight
                    ,child: TextButton(onPressed: (){}, child:forgetpass.text.make() )),
                    5.heightBox,
                   controller.isloading.value ?const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                   ): ourButton(color: redColor,title: login,textColor: whiteColor,
                    onPress: ()async{
                      controller.isloading(true);
                      await controller.loginMetthod(context: context).then((value){
                        if(value!=null){
                          VxToast.show(context, msg: loggedin);
                        Get.offAll(()=> const Home());
                        controller.isloading(false);
                        }else{
                          controller.isloading(false);
                        }
                      });
                      }
                    ).box.width(context.screenWidth -50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                     ourButton(color: golden,title: signup,textColor: redColor,onPress: (){Get.to(() => const SignUpScreen());}).box.width(context.screenWidth -50).make(),
            
               
              10.heightBox,
              loginWith.text.color(fontGrey).make(),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: lightGrey,
                    radius: 25,
                    child:Image.asset(socialList[index],width: 30,) ,
                  ),
                )),
              )
             ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
        
      ),
    ));
  }
}