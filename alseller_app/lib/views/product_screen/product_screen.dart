import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/products_controller.dart';
import 'package:alseller_app/services/store_services.dart';
import 'package:alseller_app/views/product_screen/add_product.dart';
import 'package:alseller_app/views/product_screen/products_details.dart';
import 'package:alseller_app/widgets/appbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
      await  controller.getCategories();
          controller.populatecategoryList();
          Get.to(() => const AddProduct());
        },
        backgroundColor: purpleColor,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getproducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapsot) {
            if (!snapsot.hasData) {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              );
            } else {
              var data = snapsot.data!.docs;
              print(snapsot.data!.docs[0]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ProductsDetails(data: data[index],));
                                },
                                leading: Image.network(
                                  data[index]['p_images'][0],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}", color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    normalText(text: "\$${data[index]['p_price']}", color: darkGrey),
                                    10.widthBox,
                                    boldText(text:data[index]['is_featured']==true? "Featured": '', color: green)
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                  arrowSize: 0.0,
                                  menuBuilder: () => Column(
                                    children: List.generate(
                                        popupMenuTitles.length,
                                        (i) => Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Icon(popupMenuIcons[i],
                                                  color: data[index]['featured_id']==currentUser!.uid && i==0 ?green:darkGrey),
                                                  5.widthBox,
                                                  normalText(
                                                      text:data[index]['featured_id']==currentUser!.uid && i==0 ?"Remove Feature": popupMenuTitles[i],
                                                      color: darkGrey)
                                                ],
                                              ).onTap(() {
                                                  switch(i){
                                                    case 0:
                                                    if(data[index]['is_featured']==true){
                                                    controller.removeFeatured(data[index].id);
                                                    VxToast.show(context, msg: "Removed");
                                                  }else{
                                                    controller.addFeatured(data[index].id);
                                                    VxToast.show(context, msg: "Added");
                                                  }
                                                  break;
                                                  case 1:
                                                  break;
                                                  case 2:
                                                  controller.removeProduct(data[index].id);
                                                  VxToast.show(context, msg: "Item Removed");
                                                  break;
                                                  default:
                                                  }
                                              }),
                                            )),
                                  ).box.white.rounded.width(200).make(),
                                  clickType: VxClickType.singleClick,
                                  child: const Icon(Icons.more_vert_rounded),
                                ),
                              ),
                            )),
                  ),
                ),
              );
            }
          }),
    );
  }
}
