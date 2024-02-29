import 'package:grocery_app/consts/consts.dart';

Widget DetailsCard ({width,String? count ,String? title}){
  return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    5.heightBox,
                    title!.text.fontFamily(bold).color(darkFontGrey).make(),
                  ],
                ).box.white.rounded.width(width).height(80).padding(const EdgeInsets.all(4)).make();

            
}