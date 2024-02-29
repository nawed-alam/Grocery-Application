import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/order_controller.dart';
import 'package:alseller_app/widgets/our_button.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/order_placed_details.dart';

class OrdersDetails extends StatefulWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  var controller = Get.find<OrdersCotroller>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Orders Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                color: green,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                },
                title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //order Delivery Status
                      Visibility(
                        visible: controller.confirmed.value,
                        child: Column(
                          children: [
                            boldText(
                                text: "Order Status",
                                color: fontGrey,
                                size: 16.0),
                            SwitchListTile(
                              activeColor: green,
                              value: true,
                              onChanged: (value) {},
                              title: boldText(text: "Placed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.confirmed.value,
                              onChanged: (value) {
                                controller.confirmed.value = value;
                              },
                              title:
                                  boldText(text: "Confirmed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.ondelivery.value,
                              onChanged: (value) {
                                controller.ondelivery.value = value;
                                controller.changeStatus(
                                    title: "order_on_delivery",
                                    status: value,
                                    docID: widget.data.id);
                              },
                              title: boldText(
                                  text: "On Delivery", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.delivered.value,
                              onChanged: (value) {
                                controller.delivered.value = value;
                                controller.changeStatus(
                                    title: "order_delivered",
                                    status: value,
                                    docID: widget.data.id);
                              },
                              title:
                                  boldText(text: "Deliverd", color: fontGrey),
                            ),
                          ],
                        )
                            .box
                            .shadowMd
                            .white
                            .padding(const EdgeInsets.all(8.0))
                            .border(color: lightGrey)
                            .roundedSM
                            .make(),
                      ),

                      //order details Section
                      Column(
                        children: [
                          OrderPlacedDetails(
                              data1: "${widget.data['order_code']}",
                              data2: "${widget.data['shipping_method']}",
                              title1: "Order Code",
                              title2: "Shipping Method"),
                          OrderPlacedDetails(
                              // data1: DateTime.now(),
                              data1: intl.DateFormat()
                                  .add_yMd()
                                  .format(widget.data['order_date'].toDate()),
                              data2: "${widget.data['payment_method']}",
                              title1: "Order Date",
                              title2: "Payment Method"),
                          OrderPlacedDetails(
                              data1: 'Unpaid',
                              data2: 'Order Placed',
                              title1: "Payment Status",
                              title2: "Delivery Status"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //"Shipping Address".text.fontFamily(semibold).make(),
                                    boldText(
                                        text: "Shipping Adress",
                                        color: purpleColor),
                                    "${widget.data['order_by_name']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_email']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_address']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_city']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_state']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_phone']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_postalCode']}"
                                        .text
                                        .make(),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    boldText(
                                        text: "Total Amount",
                                        color: purpleColor),
                                    boldText(
                                        text: "${widget.data['total_amount']}",
                                        color: red,
                                        size: 16.0),
                                    // "Total Amount".text.fontFamily(semibold).make(),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                          .box
                          .shadowMd
                          .white
                          .border(color: lightGrey)
                          .roundedSM
                          .make(),
                      const Divider(),
                      10.heightBox,
                      boldText(
                          text: "Order Products", color: fontGrey, size: 16.0),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children:
                            List.generate(controller.orders.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderPlacedDetails(
                                title1: "${controller.orders[index]['title']}",
                                title2: "${controller.orders[index]['tprice']}",
                                data1: "${controller.orders[index]['qty']}x",
                                data2: "Refundable",
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  width: 30,
                                  height: 20,
                                  color:
                                      Color(controller.orders[index]['color']),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }).toList(),
                      )
                          .box
                          .outerShadowMd
                          .margin(const EdgeInsets.only(bottom: 4))
                          .white
                          .make(),
                      20.heightBox,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
