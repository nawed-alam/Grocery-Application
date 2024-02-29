import 'package:grocery_app/consts/consts.dart';

Widget ourButton({onPress,color,textColor,String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(12),
    backgroundColor: color
    ),
    onPressed:onPress, child: title!.text.color(textColor).fontFamily(bold).make());

}