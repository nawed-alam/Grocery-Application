import 'dart:io';

import 'package:get/get.dart';
import 'package:grocery_app/controler/profile_controller.dart';
import 'package:grocery_app/widget_common/bg_widget.dart';
import 'package:grocery_app/widget_common/custom_textfield.dart';
import 'package:grocery_app/widget_common/our_button.dart';

import '../../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data ;
  const EditProfileScreen({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<ProfileController>();
   
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
               ()  => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
     data['imageUrl'] == ''   &&   controller.profileImgPath.isEmpty ? 
      Image.asset(imgProfile,width: 95,fit: BoxFit.cover,)
      .box.roundedFull.clip(Clip.antiAlias).make(): 
      data['imageUrl']!= '' && controller.profileImgPath.isEmpty 
      ?Image.network(data['imageUrl'],width: 95,fit: BoxFit.cover,)
      .box.roundedFull.clip(Clip.antiAlias).make():  
      Image.file(File(controller.profileImgPath.value),width:
       95,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(color: redColor,onPress: (){
                controller.changeImage(context);
              },textColor: whiteColor,title: 'Change'),
             const  Divider(),
              20.heightBox,
              customTextField(
                controller: controller.namecontroller,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldpasscontroller,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newpasscontroller,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
             controller.isloading.value ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
             ):SizedBox(
                width: context.screenWidth-60,
                child: ourButton(color: redColor,
                onPress: ()async{


                  controller.isloading(true);

                //if image is not selected 
                if(controller.profileImgPath.value.isNotEmpty){
                  await controller.uploadProfileImage();
                }else{
                  controller.profileImageLink = data['imageUrl'];
                }

                //if old password matches data base
                if(data['password'] == controller.oldpasscontroller.text){
                    await controller.changeAuthPassword(
                      email: data['email'],
                      password: controller.oldpasscontroller.text,
                      newpassword: controller.newpasscontroller.text
                     );

                  await controller.updateProfile(imgUrl: controller.profileImageLink,
                 name: controller.namecontroller.text,
                 password: controller.newpasscontroller.text);
                 
                 VxToast.show(context, msg: "Updated");

                }else{
                  VxToast.show(context, msg: "Wrong Old Password");
                  controller.isloading(false);
                }

                
                },textColor: whiteColor,title: 'Save')),
            ],
          ).box.white.shadowSm.rounded.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,left: 12,right: 12)).make(),
        ),

      )
    );
  }
}