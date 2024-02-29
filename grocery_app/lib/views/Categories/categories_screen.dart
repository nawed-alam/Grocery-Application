import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/controler/product_controller.dart';
import 'package:grocery_app/views/Categories/categories_details.dart';
import 'package:grocery_app/widget_common/bg_widget.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {

     var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding:const  EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
           itemBuilder: (context,index){
            return Column(
              children: [
                
                Image.asset(categoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                10.heightBox,
                catogeriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
              ],
            ).box.rounded.white.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {

              controller.getSubCategories(catogeriesList[index]);
              Get.to(()=>CategoryDetails(title: catogeriesList[index]));
            }) ;
          }),
        ),
      )
    );
  }
}