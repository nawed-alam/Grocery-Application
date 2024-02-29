import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/views/Categories/categories_details.dart';

import '../../../consts/list.dart';
import '../../../controler/product_controller.dart';
Widget FeaturedButton({String? title, icon,index}) {
  var controller = Get.put(ProductController());
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 95,
        height: 85, // Increase the height of the Image
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text
          .fontFamily(semibold)
          .color(darkFontGrey)
          .make(),
    ],
  ).box
    .width(150) // Adjust the width of the outer container
    .height(165) // Adjust the height of the outer container
    .margin(const EdgeInsets.all(8))
    .color(Color.fromARGB(255, 203, 188, 195))
    .padding(const EdgeInsets.all(14))
    .roundedSM
    .outerShadowSm
    .make()
    .onTap(() {
       controller.getSubCategories(catogeriesList[index]);
      Get.to(() => CategoryDetails(title: title));
    });
}

