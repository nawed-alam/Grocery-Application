import 'package:alseller_app/widgets/text_style.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/const.dart';

Widget customTextField({label,hint ,controller,isDesc =false}){
  return TextFormField(
    style:const TextStyle(color: white),
    maxLines: isDesc?4:1,
    controller: controller,
    decoration: InputDecoration(
      hintStyle: const TextStyle(color: lightGrey),
      label: normalText(text: label),
      hintText: hint,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:BorderSide(
        color: white,),
      ),
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:BorderSide(
        color: white,
      ) )
    ),
  );

}