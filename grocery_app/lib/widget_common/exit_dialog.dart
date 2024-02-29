import 'package:flutter/services.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/widget_common/our_button.dart';

Widget exitDialog (context){
  return Dialog(
    child: Column(
          mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
       const Divider(),
        10.heightBox,
        "Are you want to exit?".text.
        size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              color: redColor,
              onPress: (){
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"
            ),
          
            ourButton(
              color: redColor,
              onPress: (){
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No"
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}