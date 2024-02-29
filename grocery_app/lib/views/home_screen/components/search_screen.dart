import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/services/firestore_services.dart';
import '../../../consts/consts.dart';
import '../../Categories/items_details.dart';
class SerachScreen extends StatelessWidget {
  final String? title;

  const SerachScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Products Found".text.white.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) =>
                    element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()))
                .toList();

            if (filtered.isNotEmpty) {
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300,
                ),
                children: filtered.map((item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        item['p_images'][0],
                        height: 180,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      const Spacer(),
                      "${item['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make()
                          .centered(),
                      10.heightBox,
                      "${String.fromCharCode(8377)} ${item['p_price']}"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(16)
                          .make()
                          .centered(),
                    ],
                  ).box
                    .white
                    .roundedSM
                    .margin(const EdgeInsets.symmetric(horizontal: 5))
                    .padding(const EdgeInsets.all(12))
                    .make()
                    .onTap(() {
                      Get.to(() => ItemsDetails(
                            title: "${item['p_name']}",
                            data: item,
                          ));
                    });
                }).toList(),
              );
            } else {
              return "No Products Found".text.white.makeCentered();
            }
          }
        },
      ),
    );
  }
}
