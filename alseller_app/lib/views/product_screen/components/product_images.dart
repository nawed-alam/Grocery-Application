import 'package:alseller_app/const/const.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImages({required label,onpress}){
  return "$label".text.size(16.0).bold.color(fontGrey).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.make();
}