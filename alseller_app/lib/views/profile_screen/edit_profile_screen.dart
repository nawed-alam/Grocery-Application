import 'dart:io';

import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/profile_controller.dart';
import 'package:alseller_app/widgets/costum_textform_feild.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.namecontroller.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(red),
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      //if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      //if old password matches data base
                      if (controller.snapshotData['password'] ==
                          controller.oldpasscontroller.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpasscontroller.text,
                            newpassword: controller.newpasscontroller.text);

                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.namecontroller.text,
                            password: controller.newpasscontroller.text);

                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpasscontroller.text.isEmptyOrNull &&
                          controller.newpasscontroller.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.namecontroller.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Some Error Occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Image.asset(imgProduct,width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 95,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 95,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 95,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),

              customTextField(
                  label: name,
                  hint: "eg. Nawed Anagnos",
                  controller: controller.namecontroller),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(
                    text: "Change  Your Password",
                  )),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpasscontroller),
              10.heightBox,
              customTextField(
                  label: cinformPassword,
                  hint: passwordHint,
                  controller: controller.newpasscontroller),
            ],
          ),
        ),
      ),
    );
  }
}
