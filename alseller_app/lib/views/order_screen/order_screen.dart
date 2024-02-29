import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/order_controller.dart';
import 'package:alseller_app/views/order_screen/orders_details.dart';
import 'package:alseller_app/widgets/appbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

import '../../services/store_services.dart';
import '../../widgets/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

     var controller = Get.put(OrdersCotroller());
    return Scaffold(
      appBar: appbarWidget(orders),
       body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapsot ){
          if(!snapsot.hasData){
          return const  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(white),
                            );
          }
          else{
            var data = snapsot.data!.docs;
             // print(snapsot.data!.docs[0]);
            return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                data.length,
                (index) {
                  var time = data[index]['order_date'].toDate();
                return  ListTile(
                      onTap: () {
                        Get.to(()=> OrdersDetails(data: data[index],));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(text: "${data[index]['order_code']}", color: purpleColor),
                      subtitle: Column(
                        children: [
                          //normalText(text: "\$40.0", color: darkGrey),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text: intl.DateFormat()
                                      .add_yMd()
                                      .format(time),
                                  color: fontGrey)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red)
                            ],
                          )
                        ],
                      ),
                      trailing: boldText(
                          text: "${data[index]['total_amount']}", color: purpleColor, size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                }),
          ),
        ),
      );
          }
        }),
      
    );
  }
}
