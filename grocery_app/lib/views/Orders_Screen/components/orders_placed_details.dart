import 'package:grocery_app/consts/consts.dart';

Widget OrderPlacedDetails ({title1,title2,data1,data2}) {
  
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$title1".text.fontFamily(semibold).make(),
                          "$data1".text.color(redColor).fontFamily(semibold).make()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$title2".text.fontFamily(semibold).make(),
                          "$data2".text.fontFamily(semibold).make(),
                        ],
                      ),
                    ],
                  ),
                );
}