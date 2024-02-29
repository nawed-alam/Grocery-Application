import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title){
  return AppBar(
    backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: title, color: fontGrey, size: 16.0),
        actions: [
          Center(
              child: boldText(
                  text: intl.DateFormat('EEE,MMM d, ' 'yy')
                      .format(DateTime.now()),
                  color: purpleColor)),
          10.widthBox,
        ],
      );
}