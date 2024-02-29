import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/controler/product_controller.dart';
import 'package:grocery_app/services/firestore_services.dart';
import 'package:grocery_app/views/Categories/items_details.dart';
import 'package:grocery_app/widget_common/bg_widget.dart';

import '../../consts/consts.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
    
    @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }else{
      productMethod = FirestoreServices.getproducts(title);
    }
  }
  var controller = Get.find<ProductController>();
    dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children:List.generate(
                  controller.subcat.length, (index) => "${controller.subcat[index]}".text.fontFamily(semibold).color(darkFontGrey).makeCentered()
                  .box.white.size(120, 60).margin(const EdgeInsets.symmetric(horizontal: 4)).rounded.make().onTap(() {
                    switchCategory("${controller.subcat[index]}");
                    setState(() {
                      
                    });
                  })) ,
              ),
            ),
            40.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) {
                return Expanded(
                  child:  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: "No products found!".text.bold.color(darkFontGrey).makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Expanded(
                  
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8), itemCount: data.length,itemBuilder: (context,index){
                      return  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Image.network(
                              data[index]['p_images'][1],
                              height: 150,
                              width: 200,
                              fit: BoxFit.fill,),
                              8.heightBox,
                            "${data[index]['p_name']}".text.fontFamily(bold).color(darkFontGrey).make(),
                            8.heightBox,
                        "${String.fromCharCode(8377)} ${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make().centered(),
          
                           ],
                            ).box.white.outerShadow.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 5)).padding(const EdgeInsets.all(10)).make()
                            .onTap(() {
                              controller.checkIffav([index]);
                              Get.to(()=> ItemsDetails(title: "${data[index]['p_name']}" ,
                              data: data[index],
                              ));
                            });
                    })
                  );
             
              }
            },
          ),
        ],
      ),
    ));
  }
}
