import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/views/Orders_Screen/components/orders_placed_details.dart';
import 'package:grocery_app/views/Orders_Screen/components/orders_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Orders Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  orderStatus(color: Colors.red,icon: Icons.done,title: "Placed",showDone: data['order_placed'] ),
                  orderStatus(color: Colors.blueAccent,icon: Icons.thumb_up,title: "Confirmed",showDone: data['order_confirmed'] ),
                  orderStatus(color: Colors.yellow,icon: Icons.local_shipping,title: "On Delivery",showDone: data['order_on_delivery'] ),
                  orderStatus(color: Colors.green,icon: Icons.done_all,title: "Delivered",showDone: data['order_delivered'] ),
            
                  const Divider(),
                  10.heightBox,
                  Column(
                    children: [
                      OrderPlacedDetails(
                    data1: data['order_code'],
                    data2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method"
                  ),
                  OrderPlacedDetails(
                    data1:intl.DateFormat().add_yMd().format( data['order_date'].toDate()),
                    data2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method"
                  ),
                  OrderPlacedDetails(
                    data1: 'Unpaid',
                    data2: 'Order Placed',
                    title1: "Payment Status",
                    title2: "Delivery Status"
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalCode']}".text.make(),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                          ],
                        )
                      ],
                    ),
                  )
                    ],
                  ).box.shadowMd.white.make(),
                  const Divider(),
                  10.heightBox,
                  "Ordered Product".text.color(darkFontGrey).fontFamily(semibold).size(16).makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    children:List.generate(data['orders'].length, (index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [OrderPlacedDetails(
                            title1: data['orders'][index]['title'],
                            title2: data['orders'][index]['tprice'],
                            data1: "${data['orders'][index]['qty']}x",
                            data2: "Refundable",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(data['orders'][index]['color']),
                            ),
                          ),
                          const Divider(),
                          ],
                        );
                      }).toList(),

                  ).box.outerShadowMd.margin(const EdgeInsets.only(bottom: 4)).white.make(),
                      20.heightBox,
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}