import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/views/product_screen/products_details.dart';
import 'package:alseller_app/widgets/appbar_widget.dart';
import 'package:alseller_app/widgets/dashboard_button.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

import '../../services/store_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
     body:  StreamBuilder(
          stream: StoreServices.getproducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapsot) {
            if (!snapsot.hasData) {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              );
            } else {
              var data = snapsot.data!.docs;
              data  = data.sortedBy((a, b) => a['p_wishlist'].length.compareTo(b['p_wishlist'].length));
              print(snapsot.data!.docs[0]);
              return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context, title: products, count: "${data.length}",icon: icProducts),
                dashboardButton(context, title: orders, count: "${orders.length}",icon:icOrder ),
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context, title: rating, count: "60",icon: icStar),
                dashboardButton(context, title: totalSales, count: "15",icon: icOrder),
              ],
            ),
            10.heightBox,
            const Divider(),
            10.heightBox,
            boldText(text: popular,color: fontGrey,size: 16.0),
            20.heightBox,
            ListView(
              physics:const BouncingScrollPhysics() ,
              shrinkWrap: true,
              children: List.generate(data.length, (index) =>data[index]['p_wishlist'].length==0?const SizedBox(): Card(
                child: ListTile(
                  onTap: () {
                    Get.to(()=>ProductsDetails(data: data[index],));
                  },
                  leading: Image.network(data[index]['p_images'][0],width: 60,height: 60,fit: BoxFit.cover,),
                  title: boldText(text: "${data[index]['p_name']}",color: fontGrey),
                  subtitle: normalText(text: "${data[index]['p_price']}",color: darkGrey),
                  ),
              )),
            )
          ],
        ),
      );
            }
          }),
      
    );
  }
}
