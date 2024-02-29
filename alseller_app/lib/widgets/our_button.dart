import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/widgets/text_style.dart';

Widget ourButton({onPress,color=purpleColor,title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      //primary:color,
      padding: EdgeInsets.all(12),
    backgroundColor: color
    ),
    onPressed:onPress, child: boldText(text:title,size: 16.0,),);
}