import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/products_controller.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropdown(hint ,List<String> list ,dropvalue,ProductController controller){
  return Obx(() =>  DropdownButtonHideUnderline(
      
      child: DropdownButton(
        hint: normalText(text: "$hint",color: fontGrey),
        value: dropvalue.value==''?null :dropvalue.value,
        isExpanded: true,
        items:list.map((e){
          return DropdownMenuItem(
            child: e.toString().text.make(),
            value: e,
          );
        }).toList(), onChanged: (newvalue){
          if(hint == "Category"){
            controller.subcategoryvalue.value ='';
            controller.populatesubcategoryList(newvalue.toString());
          }
          dropvalue.value = newvalue.toString();
        })
        ).
        box.padding(const EdgeInsets.symmetric(horizontal: 4)).white.roundedSM.make(),
  );
}