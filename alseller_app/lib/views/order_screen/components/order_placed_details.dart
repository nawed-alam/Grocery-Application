import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/widgets/text_style.dart';

Widget OrderPlacedDetails({title1, title2, data1, data2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1",color: purpleColor),
            boldText(text: "$data1",color: red),
            // "$title1".text.fontFamily(semibold).make(),
            // "$data1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title2",color:purpleColor),
            boldText(text: "$data2",color: red),
          ],
        ),
      ],
    ),
  );
}
